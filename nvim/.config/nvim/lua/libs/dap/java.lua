-- https://github.com/mfussenegger/nvim-jdtls/blob/master/lua/jdtls/dap.lua
-- https://github.com/Lavosierdq/dotnvim/blob/main/lua/nvim/plugins/nvim-dap/java/init.lua
local dap = require("dap")
local utils = require("libs.utils")
local async = require("neotest.async")

local M = {}

function M.setup()
	--dap.adapters.node2 = {
	--type = "executable",
	--command = "node",
	--args = { utils.concat_paths(daps_path, "node-debug2-adapter", "out", "src", "nodeDebug.js") },
	--}
	--dap.adapters.java = start_debug_adapter
	--print("java setup")
end

function M.runSingleTest(cmd)
	print(cmd)
	--require("neotest").run.run({ strategy = "dap" })

	--require("jdtls").test_nearest_method()
	--local args = utils.parseBashCommand(cmd)
	--for _, v in ipairs(args) do
	--print(v)
	--end
	--dap.run({
	--type = "java",
	--request = "launch",
	--cwd = vim.fn.getcwd(),
	--runtimeArgs = args,
	--sourceMaps = true,
	--protocol = "inspector",
	--console = "integratedTerminal",
	--port = 5005,
	--})
	--print(cmd)
	local finish_future = async.control.future()
	local debugStarted = false
	local waitingForDebugger = false
	local java_test_port
	local result_code
	vim.fn.jobstart(cmd .. " -Dmaven.surefire.debug", {
		on_stdout = function(_, data, _)
			if not debugStarted then
				for _, output in ipairs(data) do
					java_test_port = java_test_port or string.match(output, "at%saddress%p%s(%d+)")

					if string.find(output, "Listening for transport dt_socket at address") then
						waitingForDebugger = true
					end
				end
				if java_test_port ~= nil and waitingForDebugger then
					debugStarted = true
					dap.run({
						type = "java",
						name = "Run Single Java Test",
						request = "attach",
						hostName = "localhost",
						--normally port 5005,
						port = java_test_port,
					})
				end
			end
		end,
		on_stderr = function(_, data, _)
			print("stderr ", data)
		end,
		on_exit = function(_, exit_code, _)
			finish_future.set()
			result_code = exit_code
			print("exit code ", exit_code)
		end,
	})
	if result_code == nil then
		finish_future.wait()
	end
end

return M
