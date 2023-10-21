require("lspconfig").tsserver.setup({
	on_attach = require("libs.lsps.utils").on_attach,
})
