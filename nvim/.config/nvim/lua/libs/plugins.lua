-- To install
-- :PlugInstall
-- To Remove, first remove plugin from config
-- :PlugClean
-- lua syntax
-- https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom
-- https://github.com/junegunn/vim-plug
local Plug = vim.fn["plug#"]
vim.call("plug#begin")

-- language server
-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
Plug("neovim/nvim-lspconfig")
Plug("hrsh7th/nvim-cmp") -- Autocompletion plugin
Plug("hrsh7th/cmp-nvim-lsp") -- LSP source for nvim-cmp
Plug("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp
Plug("L3MON4D3/LuaSnip") -- Snippets plugin
Plug("rafamadriz/friendly-snippets")
Plug("hrsh7th/cmp-nvim-lsp-signature-help")
Plug("vim-test/vim-test")

-- fuzzy finder
-- https://github.com/nvim-telescope/telescope.nvim
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim", { tag = "0.1.0" })

-- lsp manager
Plug("williamboman/mason.nvim")

-- status line
--Plug("beauwilliams/statusline.lua")
Plug("nvim-lualine/lualine.nvim")

-- theme
--Plug("gruvbox-community/gruvbox")
Plug("navarasu/onedark.nvim")

-- is a parser generator tool and an incremental parsing library
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
Plug("nvim-treesitter/nvim-treesitter-context")

-- git manager
Plug("tpope/vim-fugitive")

-- SQL manager
Plug("tpope/vim-dadbod")
Plug("kristijanhusak/vim-dadbod-ui")
Plug("kristijanhusak/vim-dadbod-completion")

-- look into
-- Plug('mbbill/undotree')

-- spell checker
Plug("kamykn/spelunker.vim")

-- lint manager
Plug("nvimtools/none-ls.nvim")

-- comment out lines
Plug("preservim/nerdcommenter")

Plug("github/copilot.vim")

Plug("christoomey/vim-tmux-navigator")

Plug("ThePrimeagen/harpoon")

Plug("stevearc/oil.nvim")

Plug("mfussenegger/nvim-dap")
Plug("rcarriga/nvim-dap-ui")

Plug("mfussenegger/nvim-jdtls")
Plug("WhoIsSethDaniel/mason-tool-installer.nvim")
Plug("nvim-telescope/telescope-ui-select.nvim")

Plug("mfussenegger/nvim-dap-python")

-- Experimental so could break
Plug("folke/noice.nvim")
Plug("MunifTanjim/nui.nvim")

vim.call("plug#end")
