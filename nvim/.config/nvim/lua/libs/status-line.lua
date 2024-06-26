-- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes
require("lualine").setup({
	options = { theme = "onedark" },
	sections = {
		lualine_x = {
			{
				require("noice").api.statusline.mode.get,
				cond = require("noice").api.statusline.mode.has,
				color = { fg = "#ff9e64" },
			},
		},
	},
})
