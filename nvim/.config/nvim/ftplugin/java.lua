local utils = require("libs.utils")

local path_to_jdtls = utils.concat_paths(utils.mason_path, "bin", "jdtls")

local config = {
	cmd = { path_to_jdtls },
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
}

local java_debug = utils.concat_paths(
	utils.mason_path,
	"packages",
	"java-debug-adapter",
	"extension",
	"server",
	"com.microsoft.java.debug.plugin-*.jar"
)
local bundles = {
	vim.fn.glob(java_debug, 1),
}

-- microsoft is no longer publishing the java-test extension on github which makes mason sad
--local java_test =
--utils.concat_paths(utils.vs_code_exensions_path, "packages", "java-test", "extension", "server", "*.jar")
local java_test = utils.concat_paths(utils.vs_code_exensions_path, "vscjava.vscode-java-test-*", "server", "*.jar")
vim.list_extend(bundles, vim.split(vim.fn.glob(java_test, 1), "\n"))
config["init_options"] = {
	bundles = bundles,
}

require("jdtls").start_or_attach(config)
