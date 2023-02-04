let mapleader="\<Space>"
set helplang=ja
set mouse=a
set number
set signcolumn=yes
set virtualedit=block
set ignorecase
set smartcase
set incsearch
set hlsearch
set hidden
set noshowmode
set termguicolors
" set pumblend=10
set isk+=-
set completeopt=menu,menuone,noinsert
set ttyfast
set lazyredraw

" tabキーでspaceを入力する
set expandtab
set tabstop=2
set shiftwidth=2

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

" grepをrgに置き換え
let &grepprg = 'rg --vimgrep --hidden'
set grepformat=%f:%l:%c:%m

" コマンド履歴のフィルタリング対応
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" %%で%:h<Tab>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h') . '/' : '%%'

augroup util
  autocmd!
  " 改行時にコメントを維持しない
  autocmd FileType * setlocal formatoptions-=r
  autocmd FileType * setlocal formatoptions-=o
  " https://vim-jp.org/vim-users-jp/2011/03/12/Hack-206.html
  autocmd WinEnter * checktime
  autocmd FileType qf set nobuflisted
augroup END

