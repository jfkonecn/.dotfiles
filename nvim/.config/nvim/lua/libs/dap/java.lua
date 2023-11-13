-- https://github.com/mfussenegger/nvim-jdtls/blob/master/lua/jdtls/dap.lua
-- https://github.com/Lavosierdq/dotnvim/blob/main/lua/nvim/plugins/nvim-dap/java/init.lua
local dap = require("dap")
local utils = require("libs.utils")

local daps_path = utils.concat_paths(utils.mason_path, "packages")
local api = vim.api
local uv = vim.loop
local util = require("libs.dap.java-utils")
local resolve_classname = util.resolve_classname
local with_java_executable = util.with_java_executable
local M = {}

local get_clients = vim.lsp.get_clients or vim.lsp.get_active_clients

local function fetch_needs_preview(mainclass, project, cb, bufnr)
	local params = {
		command = "vscode.java.checkProjectSettings",
		arguments = vim.fn.json_encode({
			className = mainclass,
			projectName = project,
			inheritedOptions = true,
			expectedOptions = { ["org.eclipse.jdt.core.compiler.problem.enablePreviewFeatures"] = "enabled" },
		}),
	}
	util.execute_command(params, function(err, use_preview)
		assert(not err, err and (err.message or vim.inspect(err)))
		cb(use_preview)
	end, bufnr)
end

local function enrich_dap_config(config_, on_config)
	if
		config_.mainClass
		and config_.projectName
		and config_.modulePaths ~= nil
		and config_.classPaths ~= nil
		and config_.javaExec
	then
		on_config(config_)
		return
	end
	local config = vim.deepcopy(config_)
	if not config.mainClass then
		config.mainClass = resolve_classname()
	end
	local bufnr = api.nvim_get_current_buf()
	util.execute_command({ command = "vscode.java.resolveMainClass" }, function(err, mainclasses)
		assert(not err, err and (err.message or vim.inspect(err)))

		if not config.projectName then
			for _, entry in ipairs(mainclasses) do
				if entry.mainClass == config.mainClass then
					config.projectName = entry.projectName
					break
				end
			end
		end
		config.projectName = config.projectName or ""
		with_java_executable(config.mainClass, config.projectName, function(java_exec)
			config.javaExec = config.javaExec or java_exec
			local params = {
				command = "vscode.java.resolveClasspath",
				arguments = { config.mainClass, config.projectName },
			}
			util.execute_command(params, function(err1, paths)
				assert(not err1, err1 and (err1.message or vim.inspect(err1)))
				config.modulePaths = config.modulePaths or paths[1]
				config.classPaths = config.classPaths
					or vim.tbl_filter(function(x)
						return vim.fn.isdirectory(x) == 1 or vim.fn.filereadable(x) == 1
					end, paths[2])
				on_config(config)
			end, bufnr)
		end, bufnr)
	end, bufnr)
end

local function start_debug_adapter(callback, config)
	-- User could trigger debug session for another project, open in another buffer
	local jdtls = vim.tbl_filter(function(client)
		return client.name == "jdtls" and client.config and client.config.root_dir == config.cwd
	end, get_clients())[1]
	local bufnr = vim.lsp.get_buffers_by_client_id(jdtls and jdtls.id)[1] or vim.api.nvim_get_current_buf()
	util.execute_command({ command = "vscode.java.startDebugSession" }, function(err0, port)
		assert(not err0, vim.inspect(err0))

		callback({
			type = "server",
			host = "127.0.0.1",
			port = port,
			enrich_config = enrich_dap_config,
		})
	end, bufnr)
end

function M.setup()
	--dap.adapters.node2 = {
	--type = "executable",
	--command = "node",
	--args = { utils.concat_paths(daps_path, "node-debug2-adapter", "out", "src", "nodeDebug.js") },
	--}
	dap.adapters.java = start_debug_adapter
	--print("java setup")
end

function M.runSingleTest(cmd)
	local args = utils.parseBashCommand(cmd)
	--for _, v in ipairs(args) do
	--print(v)
	--end
	dap.run({
		type = "java",
		request = "launch",
		cwd = vim.fn.getcwd(),
		runtimeArgs = args,
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
		port = 5005,
	})
end

return M
