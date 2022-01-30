let mapleader="\<Space>"

nnoremap <Leader>, :bprev<CR>
nnoremap <Leader>. :bnext<CR>
nnoremap <Leader>q :bd<CR>
nnoremap <silent> <ESC><ESC> :nohl<CR>

set helplang=ja

" カーソル可視化
set cursorline
set cursorcolumn

" mouse有効化
set mouse=a

" 行数
set number
set relativenumber
set signcolumn=yes

" 短形選択の自由度を上げる
set virtualedit=block

" 検索
set ignorecase                " 小文字のみの検索に限り小文字大文字の差を無視
set smartcase
set incsearch                 " インクリメンタルサーチ
set hlsearch                  " 検索結果をハイライト

" tabキーでspaceを入力する
set expandtab
set tabstop=2
set shiftwidth=2

" バッファ切り替え時に保存不要に
set hidden

" モードをstatusに表示しない
set noshowmode

set nobackup
set nowritebackup

" grepをrgに置き換え
let &grepprg = 'rg --vimgrep --hidden'
set grepformat=%f:%l:%c:%m
