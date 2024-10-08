local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")
-- This is your opts table
require("telescope").setup({
	defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
	},
	pickers = {
		find_files = {
			find_command = {
				"rg",
				"--files",
				"--hidden",
				"--glob",
				"!**/.git/*",
			},
		},
	},
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

require("libs.utils").map(
	"n",
	"<leader>fn",
	":lua require('telescope.builtin').grep_string({ search = vim.fn.getreg('/'):gsub('\\\\<', ''):gsub('\\\\>', '')})<CR>"
)

require("libs.utils").map(
	"n",
	"<leader>fp",
	":lua require('telescope.builtin').grep_string({ search = vim.fn.getreg('\"')})<CR>"
)

require("libs.utils").map(
	"n",
	"<leader>fP",
	":lua require('telescope.builtin').grep_string({ search = vim.fn.getreg('+')})<CR>"
)

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fr", builtin.registers, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fm", builtin.marks, {})
vim.keymap.set("n", "z=", builtin.spell_suggest, {})
vim.api.nvim_set_keymap(
	"n",
	"<leader>f/",
	':lua require("telescope.builtin").live_grep({search_dirs={vim.fn.expand("%:p")}})<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>fk", ":Telescope keymaps<CR>", { noremap = true, silent = true })
