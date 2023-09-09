require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	ensure_installed = {
		"c",
		"cmake",
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
		"yaml",
		"prisma",
	},
})

require("treesitter-context").setup({})
