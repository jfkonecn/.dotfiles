-- Copy selected text to clipboard in visual mode
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", ":m-2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-j>", ":m+1<CR>", { noremap = true, silent = true })
