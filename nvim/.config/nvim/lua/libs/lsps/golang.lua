--require("lspconfig").golangci_lint_ls.setup({})
-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
vim.lsp.config("gopls", {
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
})
