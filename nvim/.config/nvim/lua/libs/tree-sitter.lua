local languages = {
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
}

require("nvim-treesitter").setup({})
require("nvim-treesitter").install(languages)

vim.api.nvim_create_autocmd("FileType", {
	pattern = languages,
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

require("treesitter-context").setup({
	enable = true,
})

pcall(vim.treesitter.query.set, "markdown", "injections", "")
pcall(vim.treesitter.query.set, "markdown_inline", "injections", "")

vim.opt.foldmethod = "manual"
-- https://neovim.io/doc/user/fold.html#fold-commands
-- za to unfold
vim.cmd([[ set nofoldenable]])
