local dap = require("dap")
local async = require("neotest.async")

local M = {}

function M.setup()
	dap.adapters.kotlin = {
		type = "executable",
		command = "kotlin-debug-adapter",
		options = { auto_continue_if_many_stopped = false },
	}
	dap.configurations.kotlin = {
		{
			type = "kotlin",
			request = "launch",
			name = "This file",
			-- may differ, when in doubt, whatever your project structure may be,
			-- it has to correspond to the class file located at `build/classes/`
			-- and of course you have to build before you debug
			mainClass = function()
				local root = vim.fs.find("src", { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ""
				local fname = vim.api.nvim_buf_get_name(0)
				-- src/main/kotlin/websearch/Main.kt -> websearch.MainKt
				return fname:gsub(root, ""):gsub("main/kotlin/", ""):gsub(".kt", "Kt"):gsub("/", "."):sub(2, -1)
			end,
			projectRoot = "${workspaceFolder}",
			jsonLogFile = "",
			enableJsonLogging = false,
		},
	}
end

function M.runSingleTest(cmd)
	local finish_future = async.control.future()
	local debugStarted = false
	local java_test_port
	local result_code
	local all_output = ""
	print("cmd: ", cmd)
	vim.fn.jobstart(cmd .. " -Dmaven.surefire.debug", {
		on_stdout = function(_, data, _)
			if not debugStarted then
				-- output comes in chunks, so we need to concatenate it
				for _, output in ipairs(data) do
					all_output = all_output .. output
					java_test_port = java_test_port or string.match(all_output, "at%saddress%p%s(%d+)")
				end
				if java_test_port ~= nil then
					debugStarted = true
					dap.run({
						type = "kotlin",
						name = "Run Single Kotlin Test",
						request = "attach",
						hostName = "localhost",
						projectRoot = "${workspaceFolder}",
						timeout = 10000,
						-- sometimes the full port number is not caught
						-- so I assume its 5005
						port = 5005,
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
			print("exit code " .. exit_code)
		end,
	})
	if result_code == nil then
		finish_future.wait()
	end
end

return M
