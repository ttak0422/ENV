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

au TermClose * call feedkeys("i")
