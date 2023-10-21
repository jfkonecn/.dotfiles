require("lspconfig").rust_analyzer.setup({
	on_attach = require("libs.lsps.utils").on_attach,
	settings = {
		--https://rust-analyzer.github.io/manual.html#configuration
		["rust-analyzer"] = {
			check = {
				command = "clippy",
			},
		},
	},
})
