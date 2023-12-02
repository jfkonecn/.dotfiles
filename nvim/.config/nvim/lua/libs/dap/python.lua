-- https://github.com/Lavosierdq/dotnvim/blob/main/lua/nvim/plugins/nvim-dap/java/init.lua
local dap = require("dap")
local utils = require("libs.utils")

local M = {}

function M.setup()
	-- ~/.local/share/nvim/mason/packages/debugpy/venv/bin
	local python_debug = utils.concat_paths(utils.mason_path, "packages", "debugpy", "venv", "bin", "python")
	require("dap-python").setup(python_debug)
end

function M.runSingleTest(cmd)
	require("dap-python").test_method()
end

return M
