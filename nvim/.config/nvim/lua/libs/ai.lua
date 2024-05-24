require("gen").setup({
	model = "llama3",
})

vim.keymap.set({ "n", "v" }, "<leader>]", ":Gen<CR>")
