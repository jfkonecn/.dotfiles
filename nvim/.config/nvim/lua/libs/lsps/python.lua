-- https://github.com/microsoft/pyright/blob/main/docs/configuration.md
-- root_dir = require("lspconfig").util.root_pattern(".venv", "venv", "pyrightconfig.json"),
require("lspconfig").pyright.setup({
	on_attach = require("libs.lsps.utils").on_attach,
})
