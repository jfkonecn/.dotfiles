local M = {}
function M.concat_paths(...)
	local path_separator = package.config:sub(1, 1)
	local args = { ... }

	-- Join the arguments using the appropriate separator
	local path = table.concat(args, path_separator)

	return path
end

-- ~/.local/share/nvim/mason
M.mason_path = M.concat_paths(vim.fn.stdpath("data"), "mason")
M.vs_code_exensions_path = M.concat_paths("~", ".vscode", "extensions")

function M.parseBashCommand(command)
	local args = {}
	local inSingleQuote, inDoubleQuote = false, false
	local argStart = 1

	for i = 1, #command do
		local char = command:sub(i, i)

		if char == "'" and not inDoubleQuote then
			inSingleQuote = not inSingleQuote
		elseif char == '"' and not inSingleQuote then
			inDoubleQuote = not inDoubleQuote
		elseif char:match("%s") and not inSingleQuote and not inDoubleQuote then
			if i > argStart then
				local arg = command:sub(argStart, i - 1)
				table.insert(args, arg)
			end
			argStart = i + 1
		end
	end

	if argStart <= #command then
		local arg = command:sub(argStart)
		table.insert(args, arg)
	end

	return args
end

return M
