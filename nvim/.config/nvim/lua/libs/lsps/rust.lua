vim.lsp.config("rust_analyzer", {
	settings = {
		--https://rust-analyzer.github.io/manual.html#configuration
		["rust-analyzer"] = {
			check = {
				command = "clippy",
			},
		},
	},
})
