-- require('lint').linters_by_ft = {
--   markdown = {'vale',},
--   javascript = { 'eslint' },
--   javascriptreact = { 'eslint' },
--   typescript = { 'eslint' },
--   typescriptreact = { 'eslint' },
--   vue = { 'eslint' },
--   svelte = { 'eslint' },
--   astro = { 'eslint' }
-- }
--
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })
--

local null_ls = require("null-ls")
local cspell = require("cspell")

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		--null_ls.builtins.diagnostics.eslint.with({
		--condition = function(utils)
		--return utils.root_has_file({ ".eslint", ".eslintrc.json", ".eslintrc.js" })
		--end,
		--}),
		--null_ls.builtins.formatting.eslint.with({
		----condition = function(utils)
		----return utils.root_has_file({ ".eslint", ".eslintrc.json", ".eslintrc.js" })
		----end,
		--}),
		null_ls.builtins.formatting.prettier.with({
			--condition = function(utils)
			--return utils.root_has_file({ ".prettierrc", ".prettierrc.json", ".prettierrc.mjs" })
			--end,
			extra_filetypes = { "astro" },
		}),
		null_ls.builtins.diagnostics.markdownlint,
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
		--null_ls.builtins.diagnostics.pylint.with({
		--prefer_local = ".venv/bin",
		--}),
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.csharpier,
		require("none-ls.formatting.rustfmt"),
		null_ls.builtins.formatting.clang_format.with({
			filetypes = { "c", "cpp", "objc", "objcpp" },
		}),
		require("none-ls.diagnostics.cpplint"),
		require("none-ls.code_actions.eslint").with({
			extra_filetypes = { "astro" },
		}),
		require("none-ls.diagnostics.eslint").with({
			extra_filetypes = { "astro" },
		}),
		null_ls.builtins.formatting.google_java_format,
		cspell.code_actions,
		cspell.diagnostics,
		--null_ls.builtins.completion.spell,
		null_ls.builtins.hover.dictionary,
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.formatting.goimports_reviser,
		null_ls.builtins.formatting.golines,
		null_ls.builtins.diagnostics.ktlint,
		null_ls.builtins.formatting.ktlint,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
})
