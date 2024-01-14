--https://github.com/folke/noice.nvim/wiki/Configuration-Recipes
require("noice").setup({
	routes = {
		{
			view = "cmdline",
			filter = { event = "msg_showmode" },
		},
	},
})
