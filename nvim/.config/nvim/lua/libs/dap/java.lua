local dap = require("dap")
local utils = require("libs.utils")

local daps_path = utils.concat_paths(utils.mason_path, "packages")
local M = {}

function M.setup()
	--dap.adapters.node2 = {
	--type = "executable",
	--command = "node",
	--args = { utils.concat_paths(daps_path, "node-debug2-adapter", "out", "src", "nodeDebug.js") },
	--}
	print("java setup")
end

function M.runSingleTest(cmd)
	local args = utils.parseBashCommand(cmd)
	for _, v in ipairs(args) do
		print(v)
	end
	--dap.run({
	--type = "java",
	--request = "launch",
	--cwd = vim.fn.getcwd(),
	--runtimeArgs = args,
	--sourceMaps = true,
	--protocol = "inspector",
	--console = "integratedTerminal",
	--port = 5005,
	--})
end

return M
