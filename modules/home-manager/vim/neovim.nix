{ config, pkgs, lib, ... }:
let
  inherit (builtins) concatStringsSep map;
  wrap = txt: "'${txt}'";
  plugins = with pkgs.vimPlugins; [
    # support Nix
    vim-nix

    # colorscheme
    neovim-ayu

    # startift
    vim-startify

    # 定番設定
    vim-sensible

    # スペース可視化
    vim-better-whitespace

    # インデント可視化
    indentLine

    # yank可視化
    vim-highlightedyank

    # git差分可視化
    vim-gitgutter

    # vim向けeditorconfig
    editorconfig-vim

    # 対応括弧可視化
    rainbow

    # zoom
    zoomwintab-vim

    # ale
    ale

    # lightline
    lightline-vim
    lightline-bufferline
    lightline-ale

    # asyncomplete-vim
    fzf-vim
    traces-vim
    vim-closetag

    # coc
    coc-nvim

    emmet-vim

    # easymotion
    vim-easymotion

    # nerdtree
    vim-devicons
    nerdtree
    nerdtree-git-plugin
    vim-nerdtree-tabs
    vim-nerdtree-syntax-highlight

    # winresizer.vim
  ];

  cocExtensions = [ "coc-highlight" "coc-json" "coc-yaml" "coc-go" ];

  extraConfig = ''
    " カラースキーム
    colorscheme ayu-mirage " termguicolors、backgroudも設定される

    " rainbow有効化
    let g:rainbow_active = 1
    let g:rainbow_conf = {
    \	  'separately': {
    \	  	'nerdtree': 0,
    \	  }
    \ }

    " カーソル行可視化
    set cursorline

    """"""""""""
    " Commands "
    """"""""""""

    " Rgにてファイルの中身のみを検索対象に
    " 参考 (https://github.com/joshukraine/dotfiles/commit/2f38f6eae33dd91275d45e42d0bbabd741ce9909)
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \ fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

    """"""""""""""""""
    " Global keybind "
    """"""""""""""""""

    " file (content) search
    nnoremap <C-f> :Rg<CR>

    " file search
    nnoremap <Leader>p :Files<CR>

    """"""""""""""""""
    " Window keybind "
    """"""""""""""""""

    " zoom (zoomwintabの標準の割り当てを用いない)
    let g:zoomwintab_remap = 0
    nnoremap <C-w>z :ZoomWinTabToggle<CR>

    """"""""""""""""""
    " Leader keybind "
    """"""""""""""""""

    let mapleader="\<Space>"

    " 全選択
    nnoremap <Leader>a ggVG
    " 次タブのバッファを表示
    nnoremap <Leader>, :bprev<CR>
    " 前タブのバッファを表示
    nnoremap <Leader>. :bnext<CR>
    " バッファを閉じる
    nnoremap <Leader>q :bd<CR>
    " vsp
    nnoremap <Leader>v :<C-u>vs<CR>
    " sp
    nnoremap <Leader>h :<C-u>sp<CR>

    """"""""""""""
    " easymotion "
    """"""""""""""
    let g:EasyMotion_do_mapping = 0
    let g:EasyMotion_use_migemo = 1

    " 1文字
    nmap <Leader>s <Plug>(easymotion-overwin-f)
    " 2文字
    nmap <Leader>S <Plug>(easymotion-overwin-f2)

    " easymotionでもsmartcase
    let g:EasyMotion_smartcase = 1

    " カーソル下を検索
    map <Leader>j <Plug>(easymotion-j)

    " カーソル上を検索
    map <Leader>k <Plug>(easymotion-k)


    " 開いているファイルのディレクトリに自動で移動 (相対パスが機能するように)
    autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
    autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

    " mouse有効化
    set mouse=a

    " 行数
    set number         " 表示
    set relativenumber " 相対表示

    " 短形選択の自由度を上げる
    set virtualedit=block

    " tabキーでspaceを入力する
    set expandtab

    " ファイル保管
    set wildmenu

    " バッファ切り替え時に保存不要に
    set hidden

    " モードをstatusに表示しない
    set noshowmode

    " better-whitespace
    let g:better_whitespace_enabled=1
    let g:strip_whitespace_on_save=1

    """""""
    " ale "
    """""""
    let g:ale_sign_column_always = 1
    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 1
    let g:ale_open_list = 1
    " エラーと警告がなくなっても開いたままにする
    let g:ale_keep_list_window_open = 1

    """"""""""""
    " coc.nvim "
    """"""""""""
    let g:coc_global_extensions = [ ${
      concatStringsSep "," (map wrap cocExtensions)
    } ]

    " lightline
    set laststatus=2
    set showtabline=2
    let g:lightline#ale#indicator_checking = "\uf110"
    let g:lightline#ale#indicator_infos = "\uf129"
    let g:lightline#ale#indicator_warnings = "\uf071"
    let g:lightline#ale#indicator_errors = "\uf05e"
    let g:lightline#ale#indicator_ok = "\uf00c"
    let g:lightline = {
    \ 'colorscheme': 'ayu_mirage',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
    \              [ 'fileformat', 'fileencoding', 'filetype'] ],
    \ },
    \ 'tabline': {
    \   'left': [ [ 'buffers'] ],
    \   'right': [ [ 'close' ] ],
    \ },
    \ 'separator': {
    \   'left': "\ue0b4",
    \   'right': "\ue0b6",
    \ },
    \ 'subseparator': {
    \   'left': "\ue0b5",
    \   'right': "\ue0b7",
    \ },
    \ 'component_function': {
    \   'filename': 'LightlineFilename'
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers',
    \   'linter_checking': 'lightline#ale#checking',
    \   'linter_infos': 'lightline#ale#infos',
    \   'linter_warnings': 'lightline#ale#warnings',
    \   'linter_errors': 'lightline#ale#errors',
    \   'linter_ok': 'lightline#ale#ok',
    \ },
    \ 'component_type': {
    \   'buffers': 'tabsel',
    \   'linter_infos': 'right',
    \   'linter_warnings': 'warning',
    \   'linter_errors': 'error',
    \   'linter_ok': 'right',
    \ },
    \ }
    function! LightlineFilename()
      return expand('%')
    endfunction

    " 検索
    set ignorecase                " 小文字のみの検索に限り小文字大文字の差を無視
    set smartcase
    set incsearch                 " インクリメンタルサーチ
    set hlsearch                  " 検索結果をハイライト
    nnoremap <ESC><ESC> :nohl<CR> " ESC2回押しでハイライトを消す

    " grepをrgに置き換え
    let &grepprg = 'rg --vimgrep --hidden'
    set grepformat=%f:%l:%c:%m

    " ディレクトリを必要に応じて生成
    " 参考 (https://vim-jp.org/vim-users-jp/2011/02/20/Hack-202.html)
    augroup vimrc-auto-mkdir " {{{
      autocmd!
      autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
      function! s:auto_mkdir(dir, force) " {{{
        if !isdirectory(a:dir) && (a:force || input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
          call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
        endif
      endfunction " }}}
    augroup END " }}}

    " startify
    " 参考 (https://mjhd.hatenablog.com/entry/recommendation-of-vim-startify)
    function! s:filter_header(lines) abort
      let longest_line   = max(map(copy(a:lines), 'len(v:val)'))
      let centered_lines = map(copy(a:lines), 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
      return centered_lines
    endfunction
    let g:startify_custom_header = s:filter_header([
    \ '|               ▒       ▒▒▒▒      ▒▒',
    \ '|             ▒▓▓▓▒     ░▒▒▒▒   ▒▒▒▒░',
    \ '|             ▒▓▓▓▓▒     ░▒▒▒▒  ▒▒▒▒░',
    \ '|              ▒▓▓▓▓      ░▒▒▒░▒▒▒▒░',
    \ '|               ▓▓▓▓▓      ▒▒▒▒▒▒▒░',
    \ '|          ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒      ▒',
    \ '|         ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░     ▓▓▒',
    \ '|        ▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓   ▓▓▓▓',
    \ '|              ▒▒▒▒▒▓         ▒▒▒▒▒▓ ▓▓▓▓▓',
    \ '|             ▒▒▒▒▒▓           ▒▒▒▒░▓▓▓▓▓',
    \ '|     ▒▒▒▒▒▒▒▒▒▒▒▒░             ▒▒░▓▓▓▓▓▒▒▒▒▒',
    \ '|    ░▒▒▒▒▒▒▒▒▒▒▒░               ▒▓▓▓▓▓▓▓▓▓▓▓▓',
    \ '|    ░▒▒▒▒▒▒▒▒▒▒░▒               ▒▓▓▓▓▓▓▓▓▓▓▓▓     _______   ___    __',
    \ '|     ▒▒▒▒▒▒▒▒▒░▓▓▓             ▒▓▓▓▓▒            / ____/ | / / |  / /',
    \ '|         ░▒▒▒▒▒▓▓▓▓           ▒▓▓▓▓▒            / __/ /  |/ /| | / /',
    \ '|        ░▒▒▒▒  ▓▓▓▓▒         ▒▓▓▓▓▒            / /___/ /|  / | |/ /',
    \ '|        ▒▒▒▒▒   ▓▓▓▓▒▓▓▓▓▓▓▓▓░░░░░▓▓▓▓▓▓▓     /_____/_/ |_/  |___/',
    \ '|         ▒▒▒    ▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒',
    \ '|          ▒     ▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒       _    __           ___',
    \ '|               ▓▓▓▓▓▓▓▓▒     ░▒▒▒▒            | |  / /__  _____ |__ \',
    \ '|              ▒▓▓▓▓▒▓▓▓▓      ░▒▒▒░           | | / / _ \/ ___/ __/ /',
    \ '|             ▒▓▓▓▓  ▒▓▓▓▓      ░▒▒▒░          | |/ /  __/ /  _ / __/',
    \ '|             ▒▓▓▓    ▒▓▓▓▓      ▒▒▒▓          |___/\___/_/  (_)____/',
    \ ])
  '';
  cocSettings = {
    suggest = { enablePreselect = false; };
    languagesever = {
      go = {
        command = "gopls";
        rootPatterns = [ "go.mod" ];
        filetypes = [ "go" ];
      };
    };
  };
  # suggest = {
  #   enablePreselect = false;
  #   enablePreview = false;
  #   floatEnable = true;
  #   disableKind = false;
  #   disableMenu = false;
  #   disableMenuShortcut = false;
  #   preferCompleteThanJumpPlaceholder = false;
  #   fixInsertedWord = true;
  #   localityBonus = true;
  #   triggerAfterInsertEnter = false;
  #   echodocSupport = false;
  #   acceptSuggestionOnCommitCharacter = false;
  #   noselect = true;
  #   keepCompleteopt = false;
  #   removeDuplicateItems = true;
  #   snippetsSupport = true;
  #   asciiCharactersOnly = false;
  # };
  # languagesever = {
  #   go = {

  #   };
  # };
  # };
in {
  home.packages = with pkgs;
    [

    ];
  programs.neovim = {
    inherit plugins extraConfig;
    enable = true;
    package = pkgs.neovim-nightly;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    coc = {
      enable = true;
      settings = cocSettings;
    };
  };
}
