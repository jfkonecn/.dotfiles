-- mode lhs rhs
-- nnoremap
-- ^ normal mode
--  ^ don't do recursion
--      ^ map

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

-- do grep telescope search
map("n", "<leader>fw", ":lua require('telescope.builtin').grep_string({ search = vim.fn.input(\"Grep For > \")})<CR>")

map("n", "<leader>fa", ":lua require('telescope.builtin').find_files({ hidden = true})<CR>")

-- hide search results
map("n", "<leader>noh", ":noh<CR>")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "z=", builtin.spell_suggest, {})
vim.api.nvim_set_keymap("n", "<leader>fk", ":Telescope keymaps<CR>", { noremap = true, silent = true })
-- Copy selected text to clipboard in visual mode
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", ":m-2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-j>", ":m+1<CR>", { noremap = true, silent = true })

vim.cmd([[
  nnoremap ss :lua print("not java")<CR>
]])
vim.cmd([[
  autocmd FileType java nnoremap ss :lua print("java")<CR>
]])
