--Enable (broadcasting) snippet capability for completion
local htmlCapabilities = vim.lsp.protocol.make_client_capabilities()
htmlCapabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").html.setup({
	capabilities = htmlCapabilities,
})
