local harpoon = require("harpoon")
harpoon.setup({})
--print(harpoon:list())

vim.api.nvim_set_keymap(
	"n",
	"<leader>ha",
	':lua require("harpoon"):list():add()<CR>',
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>hh",
	--':lua require("harpoon.ui").toggle_quick_menu()<CR>',
	':lua require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())<CR>',
	{ noremap = true, silent = true }
)

local function set_harpoon_number_key(key)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>" .. tostring(key),
		--string.format(':lua require("harpoon.ui").nav_file(%d)<CR>', key),
		string.format(':lua require("harpoon"):list():select(%d)<CR>', key),
		{ noremap = true, silent = true }
	)
end

for i = 1, 4 do
	set_harpoon_number_key(i)
end

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

vim.keymap.set("n", "<leader>hf", function()
	toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })
