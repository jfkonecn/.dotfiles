-- copilot is dumb and will ignore these setting if they're called after initialization
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
-- disable by default
vim.g.copilot_enabled = false

require("lazy").setup({

	"folke/neodev.nvim",

	-- language server
	-- https://github.com/neovim/nvim-lspconfig
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	"neovim/nvim-lspconfig",
	"hrsh7th/nvim-cmp", -- Autocompletion plugin
	"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
	"saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
	"L3MON4D3/LuaSnip", -- Snippets plugin
	"rafamadriz/friendly-snippets",
	"hrsh7th/cmp-nvim-lsp-signature-help",

	"vim-test/vim-test",
	-- switch more to neotest when it has more language support
	-- using for dap testing for now
	"nvim-neotest/neotest",
	--"rcasnearestia/neotest-java",
	-- fuzzy finder
	-- https://github.com/nvim-telescope/telescope.nvim
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",

	-- lsp manager
	"williamboman/mason.nvim",

	-- status line
	--"beauwilliams/statusline.lua",
	"nvim-lualine/lualine.nvim",

	-- theme
	--"gruvbox-community/gruvbox",
	"navarasu/onedark.nvim",

	-- is a parser generator tool and an incremental parsing library
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"nvim-treesitter/nvim-treesitter-context",

	-- git manager
	"tpope/vim-fugitive",
	"lewis6991/gitsigns.nvim",

	--{
	--"folke/trouble.nvim",
	--dependencies = { "nvim-tree/nvim-web-devicons" },
	--},
	"nvim-tree/nvim-web-devicons",
	-- SQL manager
	"tpope/vim-dadbod",
	"kristijanhusak/vim-dadbod-ui",
	"kristijanhusak/vim-dadbod-completion",

	-- look into
	"mbbill/undotree",

	-- lint manager
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
	},
	{
		"davidmh/cspell.nvim",
		dependencies = {
			"nvimtools/none-ls.nvim",
		},
	},

	-- comment out lines
	"preservim/nerdcommenter",

	"github/copilot.vim",

	"christoomey/vim-tmux-navigator",

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	"stevearc/oil.nvim",

	"mfussenegger/nvim-dap",
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
	"leoluz/nvim-dap-go",

	"mfussenegger/nvim-jdtls",
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	"nvim-telescope/telescope-ui-select.nvim",

	"mfussenegger/nvim-dap-python",

	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
	},
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = { "luarocks.nvim" },
		config = function()
			require("rest-nvim").setup()
		end,
	},

	-- Experimental so could break
	"folke/noice.nvim",
	"MunifTanjim/nui.nvim",

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	"norcalli/nvim-colorizer.lua",

	-- AI
	"David-Kunz/gen.nvim",

	"tpope/vim-rhubarb",
})
