require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	ensure_installed = {
		"c",
		"cmake",
		"cpp",
		"c_sharp",
		"css",
		"vimdoc",
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
		"kotlin",
		"roc",
		"asm",
	},
})

require("treesitter-context").setup({})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- https://neovim.io/doc/user/fold.html#fold-commands
-- za to unfold
vim.cmd([[ set nofoldenable]])
