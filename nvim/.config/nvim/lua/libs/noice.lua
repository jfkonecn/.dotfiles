-- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes
-- https://github.com/folke/noice.nvim/wiki/A-Guide-to-Messages
-- Annoying status stuff issue
-- https://github.com/folke/noice.nvim/issues/537#issuecomment-1637528605
require("noice").setup({
	status = { lsp_progress = { event = "lsp", kind = "progress" } },
	routes = {
		{
			view = "cmdline",
			filter = { event = "msg_showmode" },
		},
		{
			filter = {
				event = "lsp",
				kind = "progress",
			},
			opts = { skip = true },
		},
	},
})
