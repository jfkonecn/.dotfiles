--Enable (broadcasting) snippet capability for completion
local htmlCapabilities = vim.lsp.protocol.make_client_capabilities()
htmlCapabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config("html", {
	capabilities = htmlCapabilities,
})
