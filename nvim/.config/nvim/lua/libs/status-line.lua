-- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes
require("lualine").setup({
	options = { theme = "onedark" },
	sections = {
		lualine_x = {
			{
				function()
					return require("noice").api.status.lsp_progress.get_hl()
				end,
				cond = function()
					return package.loaded["noice"] and require("noice").api.status.lsp_progress.has()
				end,
			},
			{
				require("noice").api.statusline.mode.get,
				cond = require("noice").api.statusline.mode.has,
				color = { fg = "#ff9e64" },
			},
		},
	},
})
