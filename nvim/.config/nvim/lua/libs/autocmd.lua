local cmd = vim.cmd
local api = vim.api

-- Highlight on yank
-- cmd [[
--  augroup YankHighlight
--    autocmd!
--    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
--  augroup end
-- ]]

local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})


cmd [[
    fun! TrimWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfun

    augroup Trimmer
        autocmd!
        autocmd BufWritePre * :call TrimWhitespace()
    augroup END
]]
