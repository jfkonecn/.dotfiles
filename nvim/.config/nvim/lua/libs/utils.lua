local M = {}
function M.concat_paths(...)
	local path_separator = package.config:sub(1, 1)
	local args = { ... }

	-- Join the arguments using the appropriate separator
	local path = table.concat(args, path_separator)

	return path
end

M.mason_path = M.concat_paths(vim.fn.stdpath("data"), "mason")

return M
