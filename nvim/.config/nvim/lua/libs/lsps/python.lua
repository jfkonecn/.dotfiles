-- https://github.com/microsoft/pyright/blob/main/docs/configuration.md
-- root_dir = require("lspconfig").util.root_pattern(".venv", "venv", "pyrightconfig.json"),
require("lspconfig").pyright.setup({})

require("lspconfig").ruff_lsp.setup({})
