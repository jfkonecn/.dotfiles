require("lspconfig").jdtls.setup({
	on_attach = require("libs.lsps.utils").on_attach,
	filetypes = { "java" },
	settings = {
		java = {
			configuration = {
				-- https://github.com/mfussenegger/nvim-jdtls
				-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
				-- And search for `interface RuntimeOption`
				-- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
				--[[
             ls /usr/lib/jvm/
            default-java               java-1.17.0-openjdk-amd64  java-17-openjdk-amd64     java-8-openjdk-amd64  openjdk-17
java-1.11.0-openjdk-amd64  java-11-openjdk-amd64      java-1.8.0-openjdk-amd64  openjdk-11

"J2SE-1.5",
"JavaSE-1.6",
"JavaSE-1.7",
"JavaSE-1.8",
"JavaSE-9",
"JavaSE-10",
"JavaSE-11",
"JavaSE-12",
"JavaSE-13"
https://github.com/Nawy/nvim-config-examples/blob/main/lsp-java/ftplugin/java.lua
                ]]
				--
				runtimes = {
					{
						name = "JavaSE-1.8",
						path = "/usr/lib/jvm/java-1.8.0-openjdk-amd64",
					},
					{
						name = "JavaSE-11",
						path = "/usr/lib/jvm/java-11-openjdk-amd64",
					},
					{
						name = "JavaSE-17",
						path = "/usr/lib/jvm/java-17-openjdk-amd64",
					},
				},
			},
		},
	},
})
