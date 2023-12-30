require("lspconfig").clangd.setup({})

require("lspconfig").cmake.setup({
	filetypes = { "cmake", "CMakeLists.txt" },
})
