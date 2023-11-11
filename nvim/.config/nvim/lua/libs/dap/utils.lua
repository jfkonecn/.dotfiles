local function runDebugger(command)
	local bufnr = vim.fn.bufnr()
	local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

	if filetype == "cs" then
		require("libs.dap.csharp").runSingleTest(command)
	elseif filetype == "javascript" or filetype == "typescript" then
		require("libs.dap.node").runSingleTest(command)
	elseif filetype == "java" then
		require("libs.dap.java").runSingleTest(command)
	else
		print("unknown filetype: ", filetype)
	end
end

return {
	runDebugger = runDebugger,
}
