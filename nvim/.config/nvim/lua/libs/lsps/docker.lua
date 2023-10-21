require("lspconfig").docker_compose_language_service.setup({
	on_attach = require("libs.lsps.utils").on_attach,
})

require("lspconfig").dockerls.setup({
	on_attach = require("libs.lsps.utils").on_attach,
})
