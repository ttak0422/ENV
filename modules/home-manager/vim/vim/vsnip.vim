imap <expr> <C-k> vsnip#jumpable(+1) ? '<Plug>(vsnip-jump-next)' : ''
smap <expr> <C-k> vsnip#jumpable(+1) ? '<Plug>(vsnip-jump-next)' : ''
imap <expr> <C-l> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : ''
smap <expr> <C-l> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : ''
