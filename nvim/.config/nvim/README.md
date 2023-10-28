# NeoVimRc

## Installation

### Install nvim

[Install FUSE](https://github.com/AppImage/AppImageKit/wiki/FUSE)
[Download latest nvim](https://github.com/neovim/neovim/releases)
Place the appimage file in ~/bin make sure the file name is nvim

### clone to this location

- %USERPROFILE%\AppData\Local\nvim (on windows)
- ~/.config/nvim (on linux)

### Requirements

    - neovim 0.9
    - [vim-plug](https://github.com/junegunn/vim-plug)
    - [ripgrep](https://github.com/BurntSushi/ripgrep)
    - zig (for windows only)

Note on windows you have to install visual studio with the c++ complier and
then run a powershell instance through visual studio - using [scoop...](https://scoop.sh/)
check if %USERPROFILE%\scoop\shims is in your path

    ```
    scoop install zig
    scoop install ripgrep
    ```

check if %USERPROFILE%\scoop\apps\ripgrep\13.0.0 is in your path
check if %USERPROFILE%\scoop\apps\zig\0.10.1 is in your path

### Cloning

    1. Clone this repo to

        - On linux ~/.config/nvim
        - On windows ~/AppData/Local/nvim

    2. Install language servers

        ```
        :Mason
        ```

    3. Install plugins

        - you'll have to run the installation twice to get it to work

        ```
        :PlugInstall
        ```

    4. Install Tree Sitter stuff

    - Note on windows you have to install visual studio with the c++ complier
      and then run a powershell instance through visual studio

        ```
        TSInstall html css c_sharp javascript typescript tsx lua
        ```

## Commands I forget

Debug Plugins

    ```
    :checkhealth
    ```

    1. Run shell command

    ```
    :! <you shell command>
    ```

    2. Enter Terminal

    ```
    :terminal
    ```

    3. Go back to normal mode inside Terminal

    ```
    <C-\><C-n>
    ```
    4. Help with Terminal
    ```
    :help terminal-emulator
    ```
    5. Adding files
    ```
    :Explore
    ```
    - j,k move up and down
    - Enter to enter a sub-directory
    - - to go up a directory
    - d to create a directory
    - % to create a file
    - more [info](https://dev.to/asyraf/how-to-make-a-new-file-or-directory-in-vim-553f)
    6. Resize windows
    Window resizing
    You can use the :resize command or its shortcut :res to change the height
    of the window. To change the height to 60 rows, use:

    ```
    :resize 60
    ```

    You can also change the height in increments. To change the height by
    increments of 5, use:

    ```
    :res +3.5
    :res 4
    ```

    You can use :vertical resize to change the width of the current window.
    To change the width to 80 columns, use:

    ```
    :vertical resize 80
    ```

    You can also change the width in increments. To change the width by
    increments of 5, use:

    ```
    :vertical resize +5
    :vertical resize -5
    ```

    Telescope

    find file
    ```
    <leader>ff
    ```

    grep file
    ```
    <leader>fg
    ```

    yank file to system clipboard
    1. Enter visual mode and hightlight the text you want
    2. enter this command
    ```
    "+y
    ```
    - Make sure you have xclip installed on linux

    turn off hightlighting from search
    ```
    :noh
    ```

## Git

    Do merge
    ```
    :G mergetool
    ```

    See diffs
    ```
    :G difftool
    ```

    See previous git files in a different window
    ```
    :Gsplit HEAD~1
    ```

    See previous version of opened file in a different window
    ```
    :Gsplit HEAD~1:%
    ```

    See git diff
    ```
    :Gdiffsplit
    ```

    checkout current file into the buffer if you save it overrides
    ```
    :Gread
    ```

## Spell Checking

    ```
    [link](https://neovim.io/doc/user/spell.html#spell-syntax)

    // get suggestions for misspelled words
    Zl

    // jump to next misspelled word
    ZN
    ZP
    ```

## Installed by Mason

    ◍ prisma-language-server (keywords: prisma)
    ◍ astro-language-server (keywords: astro)
    ◍ clang-format (keywords: c, c#, c++, json, java, javascript)
    ◍ clangd (keywords: c, c++)
    ◍ cmake-language-server (keywords: cmake)
    ◍ cpplint (keywords: c, c++)
    ◍ csharpier (keywords: c#)
    ◍ cspell (keywords: )
    ◍ css-lsp (keywords: css, scss, less)
    ◍ docker-compose-language-service (keywords: docker)
    ◍ dockerfile-language-server (keywords: docker)
    ◍ eslint-lsp (keywords: javascript, typescript)
    ◍ html-lsp (keywords: html)
    ◍ jdtls (keywords: java)
    ◍ ltex-ls (keywords: text, markdown, latex)
    ◍ lua-language-server (keywords: lua)
    ◍ markdownlint (keywords: markdown)
    ◍ netcoredbg (keywords: .net, c#, f#)
    ◍ omnisharp (keywords: c#)
    ◍ prettier (keywords: angular, css, flow, graphql, html, json, jsx, javascript, less, markdown, scss, typescript, vue, yaml)
    ◍ pylint (keywords: python)
    ◍ pyright (keywords: python)
    ◍ rust-analyzer (keywords: rust)
    ◍ rustfmt (keywords: rust)
    ◍ stylua (keywords: lua, luau)
    ◍ tailwindcss-language-server (keywords: css)
    ◍ typescript-language-server (keywords: typescript, javascript)

## Modifying VimRc

    ```
    :options  // gives all config options
    so % // loads script
    ```

## Comment out lines

    ```
    [count]<leader>cc comment out
    [count]<leader>cu uncomment
    ```

## Run workspace lua script

Add .nvimrc.lua file

## Install Co-Pilot

[Click this link](https://github.com/github/copilot.vim)

## Check key bindings

```
:Telescope keymaps
:nmap
:nmap <leader>
:verbose nmap
:vmap
:vmap <leader>
:verbose vmap
:imap
:imap <leader>
:verbose imap
```

## Local lua repos scripts

Neovim v0.9.0 onwards supports secure `.exrc`, `.nvimrc` and `.nvim.lua` file
Add .nvim.lua file to your repo

- `:help 'exrc'`
- `:help exrc`

[Disable formatting](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/SOURCES.md#disablequery)

```lua
require("null-ls").disable({
  filetypes = { "typescript", "markdown", "javascript", "json" },
  method = require("null-ls").methods.FORMATTING,
})

```

## DAP

### C\#

```lua
local dap = require("dap")

dap.configurations.cs = {
	{
		type = "coreclr",
		name = "launch - netcoredbg",
		request = "launch",
		program = "${workspaceFolder}/CSharpPlayground.Console/bin/Debug/net6.0/CSharpPlayground.Console.dll",
	},
}
```
