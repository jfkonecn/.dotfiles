--vim.diagnostic.config({
--virtual_text = false, -- Turn off inline diagnostics
--})

---- Use this if you want it to automatically show all diagnostics on the
---- current line in a floating window. Personally, I find this a bit
---- distracting and prefer to manually trigger it (see below). The
---- CursorHold event happens when after `updatetime` milliseconds. The
---- default is 4000 which is much too long
--vim.cmd("autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()")
--vim.o.updatetime = 300

-- Show all diagnostics on current line in floating window
--vim.api.nvim_set_keymap("n", "<Leader>d", ":lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
---- Go to next diagnostic (if there are multiple on the same line, only shows
---- one at a time in the floating window)
--vim.api.nvim_set_keymap("n", "<Leader>n", ":lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
---- Go to prev diagnostic (if there are multiple on the same line, only shows
---- one at a time in the floating window)
--vim.api.nvim_set_keymap("n", "<Leader>N", ":lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
