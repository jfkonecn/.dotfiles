-- icons
require("nvim-web-devicons").set_icon({
	roc = {
		icon = "󱗆",
		color = "#9c7cea",
		name = "Roc",
	},
})
-- make .roc files have the correct filetype
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.roc" },
	command = "set filetype=roc",
})

-- add roc tree-sitter
local parsers = require("nvim-treesitter.parsers").get_parser_configs()

parsers.roc = {
	install_info = {
		url = "https://github.com/faldor20/tree-sitter-roc",
		files = { "src/parser.c", "src/scanner.c" },
	},
}

vim.lsp.config("roc_ls", {
	cmd = { "roc", "experimental-lsp" },
	filetypes = { "roc" },
	root_markers = { ".git" },
})
vim.lsp.enable("roc_ls")

--require("lspconfig").roc_ls.setup({})
