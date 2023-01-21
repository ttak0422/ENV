let g:lexima_no_default_rules = 1
call lexima#set_default_rules()
" inoremap <silent><expr> <CR> pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : lexima#expand('<LT>CR>', 'i')
" inoremap <silent><expr> <BS> pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : lexima#expand('<lt>BS>', 'i')
