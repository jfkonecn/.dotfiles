require("lspconfig").rust_analyzer.setup({
	settings = {
		--https://rust-analyzer.github.io/manual.html#configuration
		["rust-analyzer"] = {
			check = {
				command = "clippy",
			},
		},
	},
})
