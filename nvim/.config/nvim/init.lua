-- :options  // gives all config options
-- so % // loads script
--
-- gut-signs was sad with this disabled
vim.opt.termguicolors = true
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
require("libs.plugins")
require("libs.neo-dev")
require("libs.mason")
require("libs.options")
require("libs.tree-sitter")
require("libs.lsps.init")
require("libs.remaps")
require("libs.autocmd")
require("libs.none-ls")
require("libs.mason-tool-installer-nvim")
require("libs.windows")
require("libs.vim-test.init")
require("libs.harpoon")
require("libs.oil")
require("libs.vim-fugitive")
require("libs.dap.init")
require("libs.diagnostic")
require("libs.telescope")
require("libs.noice")
require("libs.theme")
require("libs.status-line")
require("libs.nerd-commenter")
require("libs.undotree")
require("libs.nvim-colorizer")
require("libs.ai")
require("libs.git-signs")
require("libs.bookmarks")
