-- tailwindcss
require("lspconfig").tailwindcss.setup({
	-- https://www.reddit.com/r/neovim/comments/yukgxy/rust_yew_tailwindcss_intellisense/
	filetypes = {
		"css",
		"scss",
		"sass",
		"postcss",
		"html",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"svelte",
		"vue",
		"rust",
		"astro",
	},
	init_options = {
		userLanguages = {
			eelixir = "html-eex",
			eruby = "erb",
			-- to get rust yew to do tailwind intellisense
			rust = "html",
		},
	},
	root_dir = require("lspconfig").util.root_pattern(
		"tailwind.config.js",
		"tailwind.config.ts",
		"postcss.config.js",
		"postcss.config.ts",
		"windi.config.ts"
	),
})
