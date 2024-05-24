require("gen").setup({
	model = "llama3",
})

require("gen").prompts["Explain_Code"] = {
	prompt = "Explain the following $filetype code to me.\n$text",
	replace = false,
}
