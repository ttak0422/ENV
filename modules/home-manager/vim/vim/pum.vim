" depends lexima-vim, vim-vsnip-integ.
call pum#set_option({
      \ 'max_height': 12,
      \ 'scrollbar_char': '█',
      \ })
set wildoptions+=pum

inoremap <silent><expr> <TAB>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \ '<TAB>' : ddc#map#manual_complete()
inoremap <silent><expr> <S-TAB> pum#visible() ? '<Cmd>call pum#map#insert_relative(-1)<CR>' : '<S-TAB>'
inoremap <silent><expr> <C-n>   (pum#visible() ? '' : '<Cmd>call ddc#map#manual_complete()<CR>') . '<Cmd>call pum#map#select_relative(+1)<CR>'
inoremap <silent><expr> <C-p>   (pum#visible() ? '' : '<Cmd>call ddc#map#manual_complete()<CR>') . '<Cmd>call pum#map#select_relative(-1)<CR>'
inoremap <silent><expr> <C-e>   pum#visible() ? '<Cmd>call pum#map#cancel()<CR>'  : '<C-e>'
"inoremap <silent><expr> <CR>    pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<CR>'
" inoremap <silent><expr> <BS>    pum#visible() ? '<Cmd>call pum#map#cancel()<CR>'  : lexima#expand('<lt>BS>', 'i')
" inoremap <silent><expr> <CR>    pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : lexima#expand('<lt>CR>', 'i')
" inoremap <silent><expr> <CR>    pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : lexima#expand('<lt>CR>', 'i')
" cnoremap <silent><expr>         <CR>    pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : lexima#expand('<lt>CR>', ':')
