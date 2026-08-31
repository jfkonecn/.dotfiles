local treesitter = require("nvim-treesitter")

treesitter.setup({})
treesitter.install({
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
		"zig",
		"fsharp",
		"terraform",
		"perl",
		"templ",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

require("treesitter-context").setup({})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- https://neovim.io/doc/user/fold.html#fold-commands
-- za to unfold
vim.cmd([[ set nofoldenable]])
