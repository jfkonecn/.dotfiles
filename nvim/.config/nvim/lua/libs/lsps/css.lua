--Enable (broadcasting) snippet capability for completion
local cssCapabilities = vim.lsp.protocol.make_client_capabilities()
cssCapabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").cssls.setup({
	capabilities = cssCapabilities,
})
