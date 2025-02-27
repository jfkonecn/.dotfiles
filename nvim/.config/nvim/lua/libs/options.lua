vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8

vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.showmode = true
vim.opt.linebreak = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.exrc = true

vim.opt.spelllang = "en_us"
vim.opt.spell = true

vim.opt.pumheight = 10

vim.filetype.add({
	filename = {
		["yabairc"] = "sh",
		["skhdrc"] = "sh",
	},
})
