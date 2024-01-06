-- rest.nvim follows the RFC 2616 request format so any other http file should work without problems.
-- examples:
-- https://github.com/rest-nvim/rest.nvim/tree/main/tests
require("rest-nvim").setup({})

local bufopts = { noremap = true, silent = true }
vim.api.nvim_buf_set_keymap(0, "n", "<leader>rr", "<Plug>RestNvim", bufopts)
vim.api.nvim_buf_set_keymap(0, "n", "<leader>rp", "<Plug>RestNvimPreview", bufopts)
vim.api.nvim_buf_set_keymap(0, "n", "<leader>rl", "<Plug>RestNvimLast", bufopts)
