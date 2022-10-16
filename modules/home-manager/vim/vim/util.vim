let mapleader="\<Space>"

nnoremap <Leader>h :bprev<CR>
nnoremap <Leader>l :bnext<CR>
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

" truecolor
set termguicolors

" set nobackup
" set nowritebackup
" set noswapfile
" swap dir
set directory=/var/tmp
set backupdir=/var/tmp

" undo
set undodir=/var/tmp
set undofile

" 編集中のファイル変更時にリロード
set autoread

" cmdline非表示
" set cmdheight=0
set cmdheight=1

" 改行時にコメントを維持しない
autocmd FileType * setlocal formatoptions-=r
autocmd FileType * setlocal formatoptions-=o

" grepをrgに置き換え
let &grepprg = 'rg --vimgrep --hidden'
set grepformat=%f:%l:%c:%m

" jkのwrap対応
nnoremap j gj
nnoremap k gk

" https://vim-jp.org/vim-users-jp/2011/03/12/Hack-206.html
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END
