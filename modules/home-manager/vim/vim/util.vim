" カーソル可視化
set cursorline
set cursorcolumn

" mouse有効化
set mouse=a

" 行数
set number         " 表示
set relativenumber " 相対表示

" 短形選択の自由度を上げる
set virtualedit=block

" 検索
set ignorecase                " 小文字のみの検索に限り小文字大文字の差を無視
set smartcase
set incsearch                 " インクリメンタルサーチ
set hlsearch                  " 検索結果をハイライト

" grepをrgに置き換え
let &grepprg = 'rg --vimgrep --hidden'
set grepformat=%f:%l:%c:%m
