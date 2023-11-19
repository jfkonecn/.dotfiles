local utils = require("libs.utils")

local path_to_jdtls = utils.concat_paths(utils.mason_path, "bin", "jdtls")

local config = {
	cmd = { path_to_jdtls },
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
	on_attach = require("libs.lsps.utils").on_attach,
	--runtimes = {
	--{
	--name = "JavaSE-1.8",
	--path = "/usr/lib/jvm/java-1.8.0-openjdk-amd64",
	--},
	--{
	--name = "JavaSE-11",
	--path = "/usr/lib/jvm/java-11-openjdk-amd64",
	--},
	--{
	--name = "JavaSE-17",
	--path = "/usr/lib/jvm/java-17-openjdk-amd64",
	--},
	--},
}
require("jdtls").start_or_attach(config)
