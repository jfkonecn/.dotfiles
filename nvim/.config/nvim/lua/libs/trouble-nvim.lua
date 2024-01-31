vim.api.nvim_set_keymap("n", "<leader>xx", ':lua require("trouble").toggle()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>xw",
	':lua require("trouble").toggle("workspace_diagnostics")<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>xd",
	':lua require("trouble").toggle("document_diagnostics")<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>xq",
	':lua require("trouble").toggle("quickfix")<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>xl",
	':lua require("trouble").toggle("loclist")<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>gR",
	':lua require("trouble").toggle("lsp_references")<CR>',
	{ noremap = true, silent = true }
)
