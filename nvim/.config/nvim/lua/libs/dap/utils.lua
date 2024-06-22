local M = {}
local async = require("neotest.async")

local function is_array_of_strings(obj)
	if type(obj) ~= "table" then
		return false
	end
	for i, v in ipairs(obj) do
		if type(v) ~= "string" then
			return false
		end
	end
	return true
end

function pick_one_sync(items, prompt, label_fn)
	-- https://github.com/mfussenegger/nvim-dap/blob/66d33b7585b42b7eac20559f1551524287ded353/lua/dap/ui.lua#L55
	local choices = { prompt }
	for i, item in ipairs(items) do
		table.insert(choices, string.format("%d: %s", i, label_fn(item)))
	end
	local choice = vim.fn.inputlist(choices)
	if choice < 1 or choice > #items then
		return nil
	end
	return items[choice]
end

local function prompt_user_to_pick(options)
	--local pick
	--vim.ui.select(options, {
	--prompt = "Select test to debug:",
	--format_item = function(item)
	--return "I'd like to choose " .. item
	--end,
	--}, function(choice)
	--pick = choice
	--end)
	--return pick
	return pick_one_sync(options, "Select test to debug: ", function(item)
		return "I'd like to choose " .. item
	end)
end

local function handle_input(input)
	if is_array_of_strings(input) then
		return prompt_user_to_pick(input)
	elseif type(input) == "string" then
		return input
	else
		error("Input must be a string or an array of strings")
	end
end

function M.runDebugger(command)
	local bufnr = vim.fn.bufnr()
	local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
	command = handle_input(command)

	if command == nil then
		print("no command selected")
	elseif filetype == "cs" then
		require("libs.dap.csharp").runSingleTest(command)
	elseif filetype == "javascript" or filetype == "typescript" then
		require("libs.dap.node").runSingleTest(command)
	elseif filetype == "java" then
		require("libs.dap.java").runSingleTest(command)
	elseif filetype == "python" then
		require("libs.dap.python").runSingleTest(command)
	elseif filetype == "go" then
		require("libs.dap.golang").runSingleTest(command)
	elseif filetype == "kotlin" then
		require("libs.dap.kotlin").runSingleTest(command[1])
	else
		print("command: ", command)
		print("unknown filetype: ", filetype)
	end
end

return M
