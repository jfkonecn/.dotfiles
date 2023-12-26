-- This is your opts table
require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				-- even more opts
			}),

			-- pseudo code / specification for writing custom displays, like the one
			-- for "codeactions"
			-- specific_opts = {
			--   [kind] = {
			--     make_indexed = function(items) -> indexed_items, width,
			--     make_displayer = function(widths) -> displayer
			--     make_display = function(displayer) -> function(e)
			--     make_ordinal = function(e) -> string
			--   },
			--   -- for example to disable the custom builtin "codeactions" display
			--      do the following
			--   codeactions = false,
			-- }
		},
	},
})
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")

-- mode lhs rhs
-- nnoremap
-- ^ normal mode
--  ^ don't do recursion
--      ^ map

-- do grep telescope search
require("libs.utils").map(
	"n",
	"<leader>fw",
	":lua require('telescope.builtin').grep_string({ search = vim.fn.input(\"Grep For > \")})<CR>"
)

require("libs.utils").map("n", "<leader>fa", ":lua require('telescope.builtin').find_files({ hidden = true})<CR>")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "z=", builtin.spell_suggest, {})
vim.api.nvim_set_keymap("n", "<leader>fk", ":Telescope keymaps<CR>", { noremap = true, silent = true })
