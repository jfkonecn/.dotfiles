require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	ensure_installed = {
		"c",
		"cpp",
		"c_sharp",
		"css",
		"help",
		"html",
		"java",
		"javascript",
		"lua",
		"vim",
		"markdown",
		"query",
		"rust",
		"tsx",
		"typescript",
		"vim",
		"python",
		"astro",
	},
})

require("treesitter-context").setup({})
