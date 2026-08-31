vim.lsp.config("terraformls", {
	init_options = {
		indexing = {
			ignorePaths = { ".terraform", "examples" },
		},
	},
})
