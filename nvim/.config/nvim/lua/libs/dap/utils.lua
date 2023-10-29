local function runDebugger(command)
	local bufnr = vim.fn.bufnr()
	local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

	if filetype == "cs" then
		require("libs.dap.csharp").runSingleTest(command)
	else
		print("unknown filetype: ", filetype)
	end
end

return {
	runDebugger = runDebugger,
}
