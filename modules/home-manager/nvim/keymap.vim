" support filtering
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
nmap [b <Plug>(poslist-prev-buf)
nmap ]b <Plug>(poslist-next-buf)
" https://zenn.dev/fuzmare/articles/vim-term-escape
tnoremap <ESC> <c-\><c-n><Plug>(esc)
nnoremap <Plug>(esc)<ESC> i<ESC>
