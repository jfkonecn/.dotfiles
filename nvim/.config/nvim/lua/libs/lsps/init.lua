-- to debug
-- :LspInfo
-- :LspLog

require("libs.lsps.csharp")
require("libs.lsps.lua")
require("libs.lsps.typescript")
require("libs.lsps.c")
require("libs.lsps.rust")
require("libs.lsps.snippets")
require("libs.lsps.tailwindcss")
require("libs.lsps.css")
require("libs.lsps.html")
require("libs.lsps.java")
require("libs.lsps.markdown")
require("libs.lsps.python")
require("libs.lsps.docker")
require("libs.lsps.astro")
require("libs.lsps.prisma")
require("libs.lsps.sql")
require("libs.lsps.golang")
require("libs.lsps.kotlin")
require("libs.lsps.ltex")
require("libs.lsps.xml")

local telescopeBuiltin = require("telescope.builtin")
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		-- check if markdown file
		local bufnr = args.buf
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		--vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		--vim.keymap.set("n", "gD", telescopeBuiltin.lsp_definitions, bufopts)
		vim.keymap.set("n", "gd", telescopeBuiltin.lsp_definitions, bufopts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "gi", telescopeBuiltin.lsp_implementations, bufopts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts)
		vim.keymap.set("n", "<leader>D", telescopeBuiltin.lsp_type_definitions, bufopts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("n", "gr", telescopeBuiltin.lsp_references, bufopts)
		vim.keymap.set("n", "<leader>fe", telescopeBuiltin.diagnostics, bufopts)
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, bufopts)
	end,
})
