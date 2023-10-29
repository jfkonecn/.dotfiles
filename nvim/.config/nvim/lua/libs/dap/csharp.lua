local dap = require("dap")
local utils = require("libs.utils")

local daps_path = utils.concat_paths(utils.mason_path, "packages")

local function setup()
	dap.adapters.coreclr = {
		type = "executable",
		command = utils.concat_paths(daps_path, "netcoredbg", "netcoredbg"),
		args = { "--interpreter=vscode" },
	}
end

local function runSingleTest(cmd)
	local jobIsRunning = false
	vim.fn.jobstart("VSTEST_HOST_DEBUG=1 " .. cmd, {
		on_stdout = function(_, _, _)
			if jobIsRunning then
				return
			end
			local pid = tonumber(io.popen("pgrep -n dotnet"):read("*n"))

			jobIsRunning = true
			dap.run({
				type = "coreclr", -- Replace with your debugger type (e.g., 'csharp', 'dotnet')
				name = "Run Single .NET Test",
				request = "attach",
				processId = pid,
			})
		end,
		on_stderr = function(_, data, _)
			print("stderr ", data)
		end,
		on_exit = function(_, exit_code, _)
			print("exit code ", exit_code)
		end,
	})
	-- sleep to wait for the debugable process to start
	os.execute("sleep 1")
end

return {
	setup = setup,
	runSingleTest = runSingleTest,
}
