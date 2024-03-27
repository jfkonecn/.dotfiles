-- Copy selected text to clipboard in visual mode
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-Up>", ":resize +1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Down>", ":resize -1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Left>", ":vertical resize -1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Right>", ":vertical resize +1<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<A-k>", ":m-2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-j>", ":m+1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

local function generate_and_copy_uuid()
	local handle = io.popen("uuidgen | tr -d '\\n'")
	if handle == nil then
		print("Failed to generate UUID")
		return
	end
	local result = handle:read("*a")
	handle:close()

	vim.fn.setreg('"', result)
end

vim.api.nvim_create_user_command("UuidIntoReg", generate_and_copy_uuid, {})
