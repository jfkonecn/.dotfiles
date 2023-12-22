local vimscript = [[
autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
]]

vim.api.nvim_exec(vimscript, false)
