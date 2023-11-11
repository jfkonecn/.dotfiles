local dap = require("dap")
local utils = require("libs.utils")

local daps_path = utils.concat_paths(utils.mason_path, "packages")
local M = {}

function M.setup()
	dap.adapters.node2 = {
		type = "executable",
		command = "node",
		args = { utils.concat_paths(daps_path, "node-debug2-adapter", "out", "src", "nodeDebug.js") },
	}
end

function M.runSingleTest(cmd)
	local temp = utils.parseBashCommand(cmd)
	local args = { "--inspect-brk" }
	for _, v in ipairs(temp) do
		table.insert(args, v)
	end
	dap.run({
		type = "node2",
		request = "launch",
		cwd = vim.fn.getcwd(),
		runtimeArgs = args,
		sourceMaps = true,
		protocol = "inspector",
		skipFiles = { "<node_internals>/**/*.js" },
		console = "integratedTerminal",
		port = 9229,
	})
end

return M
