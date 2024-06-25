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

vim.api.nvim_set_keymap(
	"n",
	"<C-x>",
	':lua vim.diagnostic.open_float(0, {scope="line"})<CR>',
	{ noremap = true, silent = true }
)

vim.g.diagnostics_visible = true
local function toggle_diagnostics()
	if vim.g.diagnostics_visible then
		vim.g.diagnostics_visible = false
		vim.diagnostic.disable()
	else
		vim.g.diagnostics_visible = true
		vim.diagnostic.enable()
	end
end
vim.api.nvim_create_user_command("ToggleDiagnostics", toggle_diagnostics, {})
vim.api.nvim_set_keymap("n", "<Leader>x", ":ToggleDiagnostics<CR>", { noremap = true, silent = true })

vim.api.nvim_create_user_command("Browse", function(opts)
	if vim.loop.os_uname().sysname == "Darwin" then
		vim.fn.system({ "open", opts.fargs[1] })
	else
		vim.fn.system({ "xdg-open", opts.fargs[1] })
	end
end, { nargs = 1 })
