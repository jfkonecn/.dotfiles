if vim.loop.os_uname().sysname == "Windows" then
    require 'nvim-treesitter.install'.compilers = { "zig" }
end
