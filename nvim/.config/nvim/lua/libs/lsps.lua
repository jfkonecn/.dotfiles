-- to debug
-- :LspInfo
-- :LspLog

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local builtin = require("telescope.builtin")
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	--vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	--vim.keymap.set("n", "gD", builtin.lsp_definitions, bufopts)
	vim.keymap.set("n", "gd", builtin.lsp_definitions, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", builtin.lsp_implementations, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", builtin.lsp_references, bufopts)
	vim.keymap.set("n", "<leader>fe", builtin.diagnostics, bufopts)
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

local function is_win()
	return package.config:sub(1, 1) == "\\"
end

local function get_path_separator()
	if is_win() then
		return "\\"
	end
	return "/"
end

local path_sep = get_path_separator()
local lsps_path = vim.fn.stdpath("data") .. path_sep .. "mason" .. path_sep .. "packages" .. path_sep

require("lspconfig").omnisharp.setup({
	-- cmd = { "dotnet", "./lsps/omnisharp/OmniSharp.dll" },
	cmd = { "dotnet", lsps_path .. "omnisharp" .. path_sep .. "OmniSharp.dll" },

	-- Enables support for reading code style, naming convention and analyzer
	-- settings from .editorconfig.
	enable_editorconfig_support = true,

	-- If true, MSBuild project system will only load projects for files that
	-- were opened in the editor. This setting is useful for big C# codebases
	-- and allows for faster initialization of code navigation features only
	-- for projects that are relevant to code that is being edited. With this
	-- setting enabled OmniSharp may load fewer projects and may thus display
	-- incomplete reference lists for symbols.
	enable_ms_build_load_projects_on_demand = false,

	-- Enables support for roslyn analyzers, code fixes and rulesets.
	enable_roslyn_analyzers = true,

	-- Specifies whether 'using' directives should be grouped and sorted during
	-- document formatting.
	organize_imports_on_format = true,

	-- Enables support for showing unimported types and unimported extension
	-- methods in completion lists. When committed, the appropriate using
	-- directive will be added at the top of the current file. This option can
	-- have a negative impact on initial completion responsiveness,
	-- particularly for the first few completion sessions after opening a
	-- solution.
	enable_import_completion = true,

	-- Specifies whether to include preview versions of the .NET SDK when
	-- determining which version to use for project loading.
	sdk_include_prereleases = true,

	-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
	-- true
	analyze_open_documents_only = false,
	on_attach = on_attach,
	flags = lsp_flags,
})

require("lspconfig").lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
	on_attach = on_attach,
	flags = lsp_flags,
})

require("lspconfig").tsserver.setup({
	on_attach = on_attach,
})

local lspconfig = require("lspconfig")

local servers = {
	"clangd",
	"rust_analyzer",
}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
	})
end

-- luasnip setup
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "nvim_lsp_signature_help" },
	},
	on_attach = on_attach,
})

-- tailwindcss
require("lspconfig").tailwindcss.setup({
	-- https://www.reddit.com/r/neovim/comments/yukgxy/rust_yew_tailwindcss_intellisense/
	filetypes = {
		"css",
		"scss",
		"sass",
		"postcss",
		"html",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"svelte",
		"vue",
		"rust",
		"astro",
	},
	init_options = {
		userLanguages = {
			eelixir = "html-eex",
			eruby = "erb",
			-- to get rust yew to do tailwind intellisense
			rust = "html",
		},
	},
	root_dir = require("lspconfig").util.root_pattern(
		"tailwind.config.js",
		"tailwind.config.ts",
		"postcss.config.js",
		"postcss.config.ts",
		"windi.config.ts"
	),
	on_attach = on_attach,
})

--Enable (broadcasting) snippet capability for completion
local cssCapabilities = vim.lsp.protocol.make_client_capabilities()
cssCapabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").cssls.setup({
	capabilities = cssCapabilities,
	on_attach = on_attach,
})

--Enable (broadcasting) snippet capability for completion
local htmlCapabilities = vim.lsp.protocol.make_client_capabilities()
htmlCapabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").html.setup({
	capabilities = htmlCapabilities,
	on_attach = on_attach,
})

require("lspconfig").jdtls.setup({
	on_attach = on_attach,
})

require("lspconfig").ltex.setup({
	on_attach = on_attach,
})

require("lspconfig").pyright.setup({
	on_attach = on_attach,
})

require("lspconfig").clangd.setup({
	on_attach = on_attach,
})

require("lspconfig").rust_analyzer.setup({
	on_attach = on_attach,
	settings = {
		--https://rust-analyzer.github.io/manual.html#configuration
		["rust-analyzer"] = {
			check = {
				command = "clippy",
			},
		},
	},
})

require("lspconfig").docker_compose_language_service.setup({
	on_attach = on_attach,
})

require("lspconfig").dockerls.setup({
	on_attach = on_attach,
})

require("lspconfig").astro.setup({
	on_attach = on_attach,
})

require("lspconfig").cmake.setup({
	on_attach = on_attach,
	filetypes = { "cmake", "CMakeLists.txt" },
})
