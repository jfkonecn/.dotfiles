"echo "hello from myscript.vim"


nnoremap <leader>dt :TestNearest -strategy=debugger<CR>
function! DebuggerStrategy(cmd)
  call luaeval("require'libs.dap.utils'.runDebugger([[" . a:cmd . "]])")
endfunction
let g:test#custom_strategies = {'debugger': function('DebuggerStrategy')}
