local utils = require("libs.utils")

vim.api.nvim_set_keymap("n", "<leader>t", ":TestNearest<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>T", ":TestFile<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>a", ":TestSuite<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>l", ":TestLast<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>g", ":TestVisit<CR>", { noremap = true, silent = true })

--require("libs.vim-test.kotlin")
--local currentScriptPath = debug.getinfo(1, "S").source:sub(2)
--local currentScriptDir = vim.fn.fnamemodify(currentScriptPath, ":h")
--vim.cmd("source " .. utils.concat_paths(currentScriptDir, "kotlin.vim"))
vim.g["test#custom_runners"] = { kotlin = { "MavenTest" } }
vim.g["test#kotlin#runner"] = "maventest"
--require("neotest").setup({
--adapters = {
--require("neotest-java")({
--ignore_wrapper = false,
--}),
--},
--})
