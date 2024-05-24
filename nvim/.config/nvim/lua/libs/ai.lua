require("gen").setup({
	model = "llama3",
})

require("gen").prompts["Explain_Code"] = {
	prompt = "Explain the following $filetype code to me.\n$text",
}

require("gen").prompts["Vim_Question"] = {
	Ask = { prompt = "Please answer this neovim question for me, $input:\n$text" },
}
