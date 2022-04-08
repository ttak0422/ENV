vim.cmd([[
  function! s:skkeleton_init() abort
    call skkeleton#config({
      \ 'useSkkServer': v:true,
      \ 'globalJisyo': '~/.skk/SKK-JISYO.L',
      \ })
  endfunction
  augroup skkeleton-initialize-pre
    autocmd!
    autocmd User skkeleton-initialize-pre call s:skkeleton_init()
  augroup END
]])
