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
		null_ls.builtins.diagnostics.eslint.with({
			--condition = function(utils)
			--return utils.root_has_file({ ".eslint", ".eslintrc.json", ".eslintrc.js" })
			--end,
		}),
		--null_ls.builtins.formatting.eslint.with({
		----condition = function(utils)
		----return utils.root_has_file({ ".eslint", ".eslintrc.json", ".eslintrc.js" })
		----end,
		--}),
		null_ls.builtins.formatting.prettier.with({
			--condition = function(utils)
			--return utils.root_has_file({ ".prettierrc", ".prettierrc.json" })
			--end,
		}),
		null_ls.builtins.diagnostics.markdownlint,
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
		null_ls.builtins.diagnostics.pylint.with({
			prefer_local = ".venv/bin",
		}),
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.csharpier,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.clang_format.with({
			filetypes = { "c", "cpp", "objc", "objcpp" },
		}),
		null_ls.builtins.diagnostics.cpplint,
		null_ls.builtins.code_actions.eslint,
		null_ls.builtins.formatting.google_java_format,
		null_ls.builtins.code_actions.cspell,
		null_ls.builtins.diagnostics.cspell,
		null_ls.builtins.completion.spell,
		null_ls.builtins.hover.dictionary,
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.formatting.goimports_reviser,
		null_ls.builtins.formatting.golines,
		null_ls.builtins.formatting.xmlformat,
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
