local dap = require("dap")
local utils = require("libs.utils")

local M = {}

function M.setup()
	require("dap-go").setup()
end

function M.runSingleTest(cmd)
	require("dap-go").debug_test()
end

return M
