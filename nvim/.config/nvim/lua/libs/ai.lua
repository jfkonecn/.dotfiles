require("gen").setup({
	model = "llama3.1",
})

require("gen").prompts["Explain_Code"] = {
	prompt = "Explain the following $filetype code to me.\n$text",
}

require("gen").prompts["Neovim_Question"] = {
	prompt = "Please answer this neovim question for me, $input:\n$text",
}
