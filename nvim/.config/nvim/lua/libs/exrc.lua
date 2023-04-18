--Neovim v0.9.0 onwards supports secure .exrc, .nvimrc and .nvim.lua files. You don't need this plugin anymore.

--Just enable the 'exrc' option:

--vim.o.exrc = true
--For more information, check:

--:help 'exrc'
--:help exrc

-- disable built-in local config file support
vim.o.exrc = false

require("exrc").setup({
  files = {
    ".nvimrc.lua",
    ".nvimrc",
    ".exrc.lua",
    ".exrc",
  },
})
