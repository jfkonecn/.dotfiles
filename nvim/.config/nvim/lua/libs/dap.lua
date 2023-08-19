-- for help
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- maybe try https://github.com/puremourning/vimspector ? it's more for vim
-- :h dap-configuration

local dap = require("dap")
local utils = require("libs.utils")
local daps_path = utils.concat_paths(utils.mason_path, "packages")

vim.api.nvim_set_keymap("n", "<F9>", ':lua require("dap").toggle_breakpoint()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F5>", ':lua require("dap").continue()<CR>', { noremap = true, silent = true })

dap.adapters.coreclr = {
	type = "executable",
	command = utils.concat_paths(daps_path, "netcoredbg", "netcoredbg"),
	args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
	{
		type = "coreclr",
		name = "launch - netcoredbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
		end,
	},
}
