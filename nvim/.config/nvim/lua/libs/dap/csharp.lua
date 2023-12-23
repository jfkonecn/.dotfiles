local dap = require("dap")
local utils = require("libs.utils")
local async = require("neotest.async")

local daps_path = utils.concat_paths(utils.mason_path, "packages")
local M = {}

function M.setup()
	dap.adapters.coreclr = {
		type = "executable",
		command = utils.concat_paths(daps_path, "netcoredbg", "netcoredbg"),
		args = { "--interpreter=vscode" },
	}
end

function M.runSingleTest(cmd)
	-- checkout https://github.com/Issafalcon/neotest-dotnet
	-- https://github.com/Issafalcon/neotest-dotnet/blob/main/lua/neotest-dotnet/strategies/netcoredbg.lua
	local finish_future = async.control.future()
	local debugStarted = false
	local waitingForDebugger = false
	local dotnet_test_pid
	local result_code
	vim.fn.jobstart("VSTEST_HOST_DEBUG=1 " .. cmd, {
		on_stdout = function(_, data, _)
			if not debugStarted then
				for _, output in ipairs(data) do
					dotnet_test_pid = dotnet_test_pid or string.match(output, "Process Id%p%s(%d+)")

					if
						string.find(output, "Waiting for debugger attach...")
						or string.find(output, "Please attach debugger")
					then
						waitingForDebugger = true
					end
				end
				if dotnet_test_pid ~= nil and waitingForDebugger then
					debugStarted = true
					dap.run({
						type = "coreclr", -- Replace with your debugger type (e.g., 'csharp', 'dotnet')
						name = "Run Single .NET Test",
						request = "attach",
						processId = dotnet_test_pid,
					})
				end
			end
		end,
		on_stderr = function(_, data, _)
			for _, output in ipairs(data) do
				print("stderr ", output)
			end
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

--dap.configurations.cs = {
--{
--type = "coreclr",
--name = "launch - netcoredbg",
--request = "launch",
--program = function()
----return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
--return vim.fn.input("Path to dll: ", "${workspace}/bin/Debug/", "file")
--end,
--},
--}
