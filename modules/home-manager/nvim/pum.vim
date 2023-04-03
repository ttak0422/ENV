" depends vim-vsnip-integ.
call pum#set_option(#{
      \ padding: v:true,
      \ item_orders: ["abbr", "kind", "menu"],
      \ scrollbar_char: '█',
      \ max_height: 20,
      \ use_complete: v:true,
      \ })
inoremap <silent><expr> <C-n> pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' : '<C-n>'
inoremap <silent><expr> <C-p> pum#visible() ? '<Cmd>call pum#map#select_relative(-1)<CR>' : '<C-p>'
inoremap <silent><expr> <C-e> pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<C-e>'

autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)
inoremap <silent><expr> <CR>  pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<CR>'
inoremap <silent><expr> <C-y> pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<C-y>'

