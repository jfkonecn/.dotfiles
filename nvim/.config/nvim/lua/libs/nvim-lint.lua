require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = { { "prettier", "prettierd", "eslint" } },
		typescript = { { "prettier", "prettierd", "eslint" } },
		typescriptreact = { { "prettier", "prettierd", "eslint" } },
		javascriptreact = { { "prettier", "prettierd", "eslint" } },
		cs = { "csharpier" },
		rust = { "rustfmt" },
		cpp = { "clang_format" },
		c = { "clang_format" },
		java = { "google-java-format" },
	},
	format_after_save = {
		lsp_fallback = true,
	},
})
