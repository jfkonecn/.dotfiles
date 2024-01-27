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

-- help dap-mappings
--vim.api.nvim_set_keymap("n", "<F9>", ':lua require("dap").toggle_breakpoint()<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap("n", "<F5>", ':lua require("dap").continue()<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<F5>", function()
	require("dap").continue()
end)
vim.keymap.set("n", "<F10>", function()
	require("dap").step_over()
end)
vim.keymap.set("n", "<F11>", function()
	require("dap").step_into()
end)
vim.keymap.set("n", "<F12>", function()
	require("dap").step_out()
end)
vim.keymap.set("n", "<Leader>b", function()
	require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>B", function()
	require("dap").set_breakpoint()
end)
vim.keymap.set("n", "<Leader>lp", function()
	require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)
vim.keymap.set("n", "<Leader>dr", function()
	require("dap").repl.open()
end)
vim.keymap.set("n", "<Leader>dl", function()
	require("dap").run_last()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
	require("dap.ui.widgets").hover()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
	require("dap.ui.widgets").preview()
end)
vim.keymap.set("n", "<Leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set("n", "<Leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end)

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
require("libs.dap.java").setup()
require("libs.dap.python").setup()
require("libs.dap.golang").setup()

vim.api.nvim_set_keymap("n", "<leader>dt", ":TestNearest -strategy=debugger<CR>", { noremap = true, silent = true })

local function DebuggerStrategy(cmd)
	require("libs.dap.utils").runDebugger({ cmd })
end

vim.g["test#custom_strategies"] = { debugger = DebuggerStrategy }
