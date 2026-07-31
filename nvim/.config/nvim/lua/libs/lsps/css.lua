local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config("cssls", {
	capabilities = capabilities,
})

vim.lsp.config("css_variables", {
	settings = {
		cssVariables = {
			lookupFiles = {
				"**/*.css",
			},
		},
	},
})

vim.lsp.enable("cssmodules_ls")
vim.lsp.enable("css_variables")
vim.lsp.enable("cssls")
