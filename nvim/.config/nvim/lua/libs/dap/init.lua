-- for help
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- maybe try https://github.com/puremourning/vimspector ? it's more for vim
-- :h dap-configuration
-- https://github.com/David-Kunz/vim
-- https://www.youtube.com/watch?v=ga3Cas7vNCk
-- Mason install location: ~/.local/share/nvim/mason/packages

local dap = require("dap")
local dapui = require("dapui")
dapui.setup()
local utils = require("libs.utils")

vim.api.nvim_set_keymap("n", "<F9>", ':lua require("dap").toggle_breakpoint()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F5>", ':lua require("dap").continue()<CR>', { noremap = true, silent = true })

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

require("dap").set_log_level("DEBUG")
require("libs.dap.csharp").setup()
require("libs.dap.node").setup()

local currentScriptPath = debug.getinfo(1, "S").source:sub(2)
local currentScriptDir = vim.fn.fnamemodify(currentScriptPath, ":h")
vim.cmd("source " .. utils.concat_paths(currentScriptDir, "_init.vim"))
