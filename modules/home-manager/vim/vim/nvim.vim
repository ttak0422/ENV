" :TOhtml
let g:loaded_2html_plugin = v:true
" file
let g:loaded_gzip = v:true
let g:loaded_tar = v:true
let g:loaded_tarPlugin = v:true
let g:loaded_zip = v:true
let g:loaded_zipPlugin = v:true
" vimball
let g:loaded_vimball = v:true
let g:loaded_vimballPlugin = v:true
" keymap
tnoremap <C-[> <C-\><C-n>
augroup NvimTerm
  autocmd!
  autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
  autocmd BufWinEnter,WinEnter term://* startinsert
  " https://github.com/neovim/neovim/issues/14986 for tig
  autocmd TermClose term://\(tig*\) execute 'bdelete! ' . expand('<abuf>')
augroup END

augroup GrepCmd
  autocmd!
  autocmd QuickFixCmdPost [^l]* nested lua require("toolwindow").open_window("quickfix", {stay_after_open = true})
  autocmd QuickFixCmdPost    l* nested lopen
augroup END

