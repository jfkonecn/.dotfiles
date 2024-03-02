require("oil").setup({})
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
--vim.keymap.set("n", "-", ":Explore<CR>", { desc = "Open parent directory" })
