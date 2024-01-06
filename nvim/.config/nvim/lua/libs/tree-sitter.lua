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
		"http",
		"json",
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
		"sql",
		"yaml",
		"prisma",
		"go",
		"gomod",
	},
})

require("treesitter-context").setup({})
