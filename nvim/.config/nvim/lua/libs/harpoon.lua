vim.api.nvim_set_keymap(
	"n",
	"<leader>ha",
	':lua require("harpoon.mark").add_file()<CR>',
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>hh",
	':lua require("harpoon.ui").toggle_quick_menu()<CR>',
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>ht",
	':lua require("harpoon.ui").nav_next()<CR>',
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>hT",
	':lua require("harpoon.ui").nav_prev()<CR>',
	{ noremap = true, silent = true }
)

local function set_harpoon_number_key(key)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>" .. tostring(key),
		string.format(':lua require("harpoon.ui").nav_file(%d)<CR>', key),
		{ noremap = true, silent = true }
	)
end

for i = 1, 4 do
	set_harpoon_number_key(i)
end
