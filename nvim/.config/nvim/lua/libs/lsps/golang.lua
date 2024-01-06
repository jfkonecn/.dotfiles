--require("lspconfig").golangci_lint_ls.setup({})
-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
require("lspconfig").gopls.setup({
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
})
