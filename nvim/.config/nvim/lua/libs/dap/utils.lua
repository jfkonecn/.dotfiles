local M = {}

function M.runDebugger(command)
	local bufnr = vim.fn.bufnr()
	local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
	command = command[1]

	if command == nil then
		print("no command selected")
	elseif filetype == "cs" then
		require("libs.dap.csharp").runSingleTest(command)
	elseif filetype == "javascript" or filetype == "typescript" then
		require("libs.dap.node").runSingleTest(command)
	elseif filetype == "java" then
		require("libs.dap.java").runSingleTest(command)
	elseif filetype == "python" then
		require("libs.dap.python").runSingleTest(command)
	elseif filetype == "go" then
		require("libs.dap.golang").runSingleTest(command)
	elseif filetype == "kotlin" then
		require("libs.dap.kotlin").runSingleTest(command[1])
	else
		print("command: ", command)
		print("unknown filetype: ", filetype)
	end
end

return M
