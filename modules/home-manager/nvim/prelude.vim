set helplang=ja
set mouse=a
set number
set signcolumn=yes
set virtualedit=block
set ignorecase
set smartcase
set hlsearch
set incsearch
set hidden
set noshowmode
set termguicolors
set isk+=-
set autoread
set showmatch
set completeopt=menu,menuone,noinsert

autocmd WinEnter * checktime
autocmd FileType qf set nobuflisted
autocmd FileType * setlocal formatoptions-=r
autocmd FileType * setlocal formatoptions-=o

