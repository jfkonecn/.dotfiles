local function concat_paths(...)
	local path_separator = package.config:sub(1, 1)
	local args = { ... }

	-- Join the arguments using the appropriate separator
	local path = table.concat(args, path_separator)

	return path
end

local mason_path = concat_paths(vim.fn.stdpath("data"), "mason")

return {
	concat_paths = concat_paths,
	mason_path = mason_path,
}
