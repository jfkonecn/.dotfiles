vim.keymap.set("i", "<F2>", 'copilot#Accept("\\<CR>")', {
	silent = true,
	expr = true,
	replace_keycodes = false,
})

vim.keymap.set("i", "<F3>", "copilot#Previous()", {
	silent = true,
	expr = true,
})

vim.keymap.set("i", "<F4>", "copilot#Next()", {
	silent = true,
	expr = true,
})

vim.g.copilot_no_tab_map = true
vim.g.copilot_filetypes = {
	markdown = true,
}
