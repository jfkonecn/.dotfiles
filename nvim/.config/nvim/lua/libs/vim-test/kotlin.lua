vim.g["test#custom_runners"] = { kotlin = { "MavenTest" } }

if vim.g["test#kotlin#maventest#file_pattern"] == nil then
	vim.g["test#kotlin#maventest#file_pattern"] = "\\v([Tt]est.*|.*[Tt]est(s|Case)?)\\.kt$"
end

function TestFile(file)
	print("test#kotlin#maventest#file_pattern")
	if vim.g["test#kotlin#runner"] ~= nil then
		if vim.g["test#kotlin#runner"] == "maventest" then
			return 1
		elseif vim.g["test#kotlin#runner"] ~= "maventest" then
			return 0
		end
	end
	local pomFile = GetPomFile(file)
	return vim.fn.match(file, vim.g["test#kotlin#maventest#file_pattern"]) ~= -1 and #pomFile > 0 and 1 or 0
end
vim.g["test#kotlin#maventest#test_file"] = TestFile

function BuildPosition(type, position)
	local filename = vim.fn.fnamemodify(position.file, ":t:r")
	local package = GetKotlinPackage(position.file)
	local module = GetMavenModule(position.file)
	local test_cmd = "test -Dtest="

	if filename:match("IT|ITCase|Integration$") and type:match("^nearest|file$") then
		local skip_it_plugins =
			" -Dsonar.skip=true -Dpit.report.skip=true -Dpit.skip=true -Dpmd.skip=true -Dcheckstyle.skip=true -Ddependency-check.skip=true -Djacoco.skip=true -Dfailsafe.only=true"
		test_cmd = "verify" .. skip_it_plugins .. " -Dit.test="
	end

	if type == "nearest" then
		local name = NearestTest(position)
		if name ~= "" then
			return { test_cmd .. package .. "." .. name .. module }
		else
			return { test_cmd .. package .. "." .. filename .. "\\*" .. module }
		end
	elseif type == "file" then
		return { test_cmd .. package .. "." .. filename .. "\\*" .. module }
	elseif type == "integration" then
		return { "verify -Dit.test=" .. filename .. "\\*" .. module }
	else
		return { "test" .. module }
	end
end
vim.g["test#kotlin#maventest#build_position"] = BuildPosition

function BuildArgs(args)
	return args
end
vim.g["test#kotlin#maventest#build_args"] = BuildArgs

function Executable()
	if vim.fn.findfile("mvnw") == "mvnw" then
		return "./mvnw"
	else
		return "mvn"
	end
end
vim.g["test#kotlin#maventest#executable"] = Executable

function GetKotlinPackage(filepath)
	local abspath = vim.fn.fnamemodify(filepath, ":p")
	abspath = abspath:gsub("\\", "/")
	local relpath = abspath:gsub("^.*src/(main|test)/(mavin/)?", "")
	local package_path = relpath:gsub("/[^/]+$", "")
	local kotlin_package = package_path:gsub("/", ".")
	return kotlin_package
end

function GetMavenModule(filepath)
	local project_dir = GetKotlinProjectDirectory(filepath)
	local parent = vim.fn.fnamemodify(project_dir, ":p:h:h")
	if vim.fn.filereadable(parent .. "/pom.xml") == 1 then
		return " -pl " .. project_dir
	else
		return ""
	end
end

function GetKotlinProjectDirectory(filepath)
	local pomFile = GetPomFile(filepath)
	if #pomFile > 0 then
		return vim.fn.fnamemodify(pomFile, ":h")
	else
		return nil
	end
end

function PomFilename(dir)
	local fn = dir .. "/pom.xml"
	if vim.fn.filereadable(vim.fn.expand(fn)) == 1 then
		return fn
	end
	return ""
end

function GetFileParentDir(file)
	return vim.fn.fnamemodify(file, ":h")
end

function GetPomFile(pwd)
	if pwd == "/" then
		return nil
	end

	local pomFile = PomFilename(pwd)
	if #pomFile > 0 then
		return pomFile
	end

	local loops = 0
	local parent = GetFileParentDir(pwd)
	local maxFuncDepth = 20
	while #pomFile == 0 and loops <= maxFuncDepth do
		pomFile = PomFilename(parent)
		parent = GetFileParentDir(parent)
		loops = loops + 1
	end

	return pomFile
end

function NearestTest(position)
	local name = vim.g["test#base#nearest_test"](position, vim.g["test#kotlin#patterns"])
	local dtest_str = table.concat(name.namespace, "$") .. "#" .. table.concat(name.test, "$")
	return vim.fn.escape(dtest_str, "#$")
end
