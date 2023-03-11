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
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

" set pumblend=10
set pumheight=10
set isk+=-
set completeopt=menu,menuone,noinsert
set ttyfast
" set lazyredraw

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

" for wezterm
" https://wezfurlong.org/wezterm/faq.html#how-do-i-enable-undercurl-curly-underlines
" tempfile=$(mktemp) \
"   && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
"   && tic -x -o ~/.terminfo $tempfile \
"   && rm $tempfile
