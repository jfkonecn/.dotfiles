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

    - neovim 0.10
    - [ripgrep](https://github.com/BurntSushi/ripgrep)
    - zig (for windows only)

Note on windows you have to install visual studio with the c++ compiler and
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

    ◍ clangd
    ◍ clang-format
    ◍ csharpier
    ◍ typescript-language-server
    ◍ pyright
    ◍ rust-analyzer
    ◍ google-java-format
    ◍ astro-language-server
    ◍ cmake-language-server
    ◍ cpplint
    ◍ cspell
    ◍ css-lsp
    ◍ docker-compose-language-service
    ◍ dockerfile-language-server
    ◍ eslint-lsp
    ◍ html-lsp
    ◍ java-debug-adapter
    ◍ jdtls
    ◍ ltex-ls
    ◍ lua-language-server
    ◍ markdownlint
    ◍ netcoredbg
    ◍ node-debug2-adapter
    ◍ omnisharp
    ◍ prettier
    ◍ prisma-language-server
    ◍ pylint
    ◍ rustfmt
    ◍ stylua
    ◍ tailwindcss-language-server

## Installed by VSCode

    [Test Runner for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-test)

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

Add .nvim.lua file

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

### Create .ignore file so Telescope can find gitignore files

.ignore file

```txt
!.ignore
!.nvim.lua
!.env
```

### Snippets

[Disable formatting](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/SOURCES.md#disablequery)

```lua
require("null-ls").disable({
  filetypes = { "typescript", "markdown", "javascript", "json" },
  method = require("null-ls").methods.FORMATTING,
})

vim.lsp.buf.format({ timeout_ms = 2000 })

```

## Local Configs

### Python

#### Setup virtual environments

```sh
echo '{ "venvPath": ".", "venv": ".venv" }' > pyrightconfig.json
```

## DAP

### C\#

    ```lua
    require("dap").configurations.cs = {
        {
            type = "coreclr",
            name = "launch - netcoredbg",
            request = "launch",
            program = "${workspaceFolder}/CSharpPlayground.Console/bin/Debug/net6.0/CSharpPlayground.Console.dll",
        },
    }

    require("dap").configurations.java = {
        {
            projectName = "java-playground",
            mainClass = "com.advent.of.code.App",
            name = "Launch Java Playground",
            request = "launch",
            type = "java",
        },
    }

    ```

## HTTP

```http
####
GET http://localhost:9000/api/account
Authorization: Bearer xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
####

```

## Linux Help

Get process id listening on port and kill it.

```sh
sudo ss -lptn 'sport = :5005'
kill <pid>
```

## Explore Help

[here](https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/)

## Scrolling

NeoVim, like Vim, offers a variety of scrolling commands that can help you navigate your files more efficiently. Here's a list of some commonly used scrolling hotkeys:

Centering, Top, and Bottom:

zz: Centers the line with the cursor on the screen.
zt: Moves the line with the cursor to the top of the screen.
zb: Moves the line with the cursor to the bottom of the screen.
Scrolling Lines:

Ctrl-e: Scrolls the window downwards by one line without moving the cursor.
Ctrl-y: Scrolls the window upwards by one line without moving the cursor.
Scrolling Half-pages:

Ctrl-d: Scrolls down half a page.
Ctrl-u: Scrolls up half a page.
Scrolling Full Pages:

Ctrl-f: Scrolls forward one full screen.
Ctrl-b: Scrolls back one full screen.
Jumping to Specific Locations:

H: Moves the cursor to the top (High) of the screen.
M: Moves the cursor to the middle of the screen.
L: Moves the cursor to the bottom (Low) of the screen.
G: Jumps to a specific line in the document (e.g., 50G jumps to line 50). Without a number, it goes to the last line of the document.
Percentage Scrolling:

50%: Jumps to the line at the given percentage of the document (in this case, 50%).
These commands can significantly enhance your navigation efficiency within your documents in NeoVim. It's worth experimenting with them to see which ones best fit your workflow.

## Git Merge Conflict

View locations of merge conflicts

    ```vim
    :Git mergetool
    ```

Open up 3 way split viewer

    ```vim
    :Gvdiffsplit!
    ```

Left is target branch
Right is merge branch
Middle is working copy

Pick a side you want to pull from

    ```vim
    :diffget <sourceFilePath>
    ```

Push change from one file to another

    ```vim
    :diffput <targetFilePath>
    ```

Close all other windows to return to normal mode

    ```vim
    <C-W><C-O>
    ```
