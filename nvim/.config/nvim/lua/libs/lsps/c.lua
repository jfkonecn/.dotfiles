require("lspconfig").clangd.setup({
	on_attach = require("libs.lsps.utils").on_attach,
})

require("lspconfig").cmake.setup({
	on_attach = require("libs.lsps.utils").on_attach,
	filetypes = { "cmake", "CMakeLists.txt" },
})
