require("lspconfig").terraformls.setup({
	init_options = {
		indexing = {
			ignorePaths = { ".terraform", "examples" },
		},
	},
})
