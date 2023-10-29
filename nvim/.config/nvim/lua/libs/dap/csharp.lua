local dap = require("dap")
local utils = require("libs.utils")

local daps_path = utils.concat_paths(utils.mason_path, "packages")

local function setup()
	dap.adapters.coreclr = {
		type = "executable",
		command = utils.concat_paths(daps_path, "netcoredbg", "netcoredbg"),
		args = { "--interpreter=vscode" },
	}
end

-- example command
-- dotnet test /home/jfkonecn/repos/csharp-playground/CSharpPlayground.Console.Tests/CSharpPlayground.Console.Tests.csproj --filter FullyQualifiedName=CSharpPlayground.Console.Tests.CodeWarsTests.ToWeirdCaseTest

local function runSingleTest(cmd)
	-- example cmd
	-- dotnet test /home/jfkonecn/repos/csharp-playground/CSharpPlayground.Console.Tests/CSharpPlayground.Console.Tests.csproj --filter FullyQualifiedName=CSharpPlayground.Console.Tests.CodeWarsTests.ToWeirdCaseTest
	--
	--print("running single test")
	--print("cmd " .. cmd)
	--print("cwd " .. vim.fn.getcwd())
	--print("done running single test")
	--{
	--type = "coreclr",
	--name = "launch - netcoredbg",
	--request = "launch",
	--program = "${workspaceFolder}/CSharpPlayground.Console/bin/Debug/net6.0/CSharpPlayground.Console.dll",
	--},

	dap.run({
		type = "coreclr", -- Replace with your debugger type (e.g., 'csharp', 'dotnet')
		name = "Run Single .NET Test",
		request = "launch",
		program = "/home/jfkonecn/repos/csharp-playground/CSharpPlayground.Console.Tests/CSharpPlayground.Console.Tests.csproj",
		args = { "--filter", "FullyQualifiedName=CSharpPlayground.Console.Tests.CodeWarsTests.ToWeirdCaseTest" },
		--cwd = "${workspaceFolder}",
		----stopAtEntry = false,
		--serverReadyAction = {
		--action = "openExternally",
		--pattern = "Now listening on",
		--},
		--console = "internalConsole",
		--pipeTransport = {
		--pipeProgram = "powershell",
		--pipeArgs = { "-NoExit", "-Command" },
		--debuggerPath = "${env:DOTNET_ROOT}/.dotnet/dotnet",
		--},
		--logging = {
		--engineLogging = true,
		--trace = true,
		--traceResponse = true,
		--},
	})
end

return {
	setup = setup,
	runSingleTest = runSingleTest,
}
