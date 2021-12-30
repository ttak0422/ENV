{ config, pkgs, lib, ... }:

let
  inherit (builtins) concatStringsSep map fetchTarball readFile;
  inherit (lib.lists) singleton;
  inherit (pkgs.vimUtils) buildVimPlugin;
  templates = pkgs.callPackage ./templates { };
  external = pkgs.callPackage ./external.nix { };
  wrap = txt: "'${txt}'";
  mkVimPlugin = cfg:
    buildVimPlugin {
      pname = cfg.name;
      version = cfg.version;
      src = cfg.src;
    };
  mkVimPlugin' = buildVimPlugin;
  plugins = (with pkgs.vimPlugins; [
    # icon
    vim-devicons
    nvim-web-devicons

    # treesitter
    nvim-treesitter
    nvim-treesitter-context
    nvim-treesitter-refactor
    nvim-treesitter-textobjects

    # diff
    diffview-nvim

    # lua
    plenary-nvim

    # nui
    nui-nvim

    # stabilize
    stabilize-nvim

    # yank
    vim-oscyank

    # registers
    registers-nvim

    # tab
    {
      plugin = supertab;
      config = ''
        let g:SuperTabDefaultCompletionType = "<c-n>"
      '';
    }

    # support Nix
    vim-nix

    # colorscheme
    neovim-ayu

    # startify
    vim-startify

    # 定番設定
    vim-sensible

    # スペース可視化
    vim-better-whitespace

    # インデント可視化
    # indentLine
    indent-blankline-nvim

    # yank可視化
    vim-highlightedyank

    # git
    gitsigns-nvim

    # vim向けeditorconfig
    editorconfig-vim

    {
      plugin = quick-scope;
      config = ''
        let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
      '';
    }

    # 対応括弧可視化
    {
      plugin = rainbow;
      config = ''
        let g:rainbow_active = 1
        let g:rainbow_conf = {
          \	  'separately': {
          \	  	'nerdtree': 0,
          \	  }
          \ }
      '';
    }

    # zoom
    zoomwintab-vim

    {
      plugin = ale;
      config = ''
        let g:ale_sign_column_always = 1
        let g:ale_set_loclist = 0
        let g:ale_set_quickfix = 1
        let g:ale_open_list = 1
        let g:ale_keep_list_window_open = 0
        let g:ale_list_window_size = 4
        let g:ale_java_javac_executable = "javac -cp ${pkgs.lombok}/share/java/lombok.jar"
      '';
    }

    # feline
    # feline-nvim
    lightline-vim
    lightline-ale

    # tab
    # bufferline-nvim
    barbar-nvim

    # whichkey
    which-key-nvim

    # telescope
    telescope-nvim
    telescope-fzf-native-nvim
    telescope-cheat-nvim

    traces-vim
    vim-closetag

    # vista
    vista-vim

    # {
    #   plugin = coc-nvim;
    #   config = ''
    #     let g:coc_global_extensions = [ ${
    #       concatStringsSep "," (map wrap cocExtensions)
    #     } ]
    #   '';
    # }

    emmet-vim

    # easymotion
    vim-easymotion

    # nerdtree
    nerdtree
    nerdtree-git-plugin
    vim-nerdtree-tabs
    vim-nerdtree-syntax-highlight

    # winresizer.vim

    # terminal
    vim-floaterm

    # zen
    goyo-vim
    limelight-vim

    # git
    gitsigns-nvim

    # cursor
    specs-nvim

    nvim-scrollview

    # command line
    wilder-nvim

    # hl
    nvim-hlslens

    # buffer
    nvim-bufdel

    # nortification
    nvim-notify

    # todo comment
    todo-comments-nvim

    # package version
    package-info-nvim

    # action
    nvim-lightbulb
    nvim-code-action-menu

    # brackets
    auto-pairs

    {
      plugin = vim-quickrun;
      config = ''
        let g:quickrun_config={'*': {'split': '''}}
        set splitbelow
      '';
    }

    {
      plugin = nvim-code-action-menu;
      config = "";
    }

    {
      plugin = nvim-bqf;
      config = "";
    }

    # debug
    {
      plugin = vimspector;
      config = ''
        let g:vimspector_enable_mappings = 'HUMAN'
      '';
    }

    trouble-nvim
    # wip...
    # https://github.com/chentau/marks.nvim
    # https://github.com/numToStr/FTerm.nvim
  ]) ++ [
    external.fzy-lua-native
  ]
  # wip...
    ++ map mkVimPlugin [
      {
        name = "vim-choosewin";
        version = "1.5.0";
        src = fetchTarball {
          url =
            "https://github.com/t9md/vim-choosewin/archive/refs/tags/v1.5.tar.gz";
          sha256 = "1lqj0yxkpr007y867b9lmxw7yrfnsnq603bsa2mpbalhv5xgayif";
        };
      }
      {
        name = "winresizer";
        version = "1.1.1";
        src = fetchTarball {
          url =
            "https://github.com/simeji/winresizer/archive/refs/tags/v1.1.1.tar.gz";
          sha256 = "08mbhckjawyawjgii8qqsdzvqvs8d0vra0fab75cdi4x08f0az94";
        };
      }
      {
        name = "vim-doc";
        version = "1.0.0";
        src = fetchTarball {
          url =
            "https://github.com/vim-jp/vimdoc-ja/archive/bc4132b074d99ff399c63a0f6611bb890118b324.tar.gz";
          sha256 = "0nmrc8mps08hmw2hyl9pyvjlx9hhknzvdy4xfjig6q36kn537yy6";
        };
      }
      {
        name = "comfortable-motion-vim";
        version = "1.0.0";
        src = fetchTarball {
          url =
            "https://github.com/yuttie/comfortable-motion.vim/archive/e20aeafb07c6184727b29f7674530150f7ab2036.tar.gz";
          sha256 = "13chwy7laxh30464xmdzjhzfcmlcfzy11i8g4a4r11m1cigcjljb";
        };
      }
      {
        name = "denops-helloworld-vim";
        version = "2.0.0";
        src = fetchTarball {
          url =
            "https://github.com/vim-denops/denops-helloworld.vim/archive/refs/tags/v2.0.0.tar.gz";
          sha256 = "0wslmcj2iwfb6gam0ff5cgqfgahkf37430hyy3azarsdchl95dwx";
        };
      }
      {
        name = "vim-quickhl";
        version = "1.0.0";
        src = fetchTarball {
          url =
            "https://github.com/t9md/vim-quickhl/archive/be1f44169c3fdee3beab629e83380515da03835e.tar.gz";
          sha256 = "1ppyvvwciw1c2m40nwlr3mhnzxy7nfxjz3bvc9jxpyym2xvl1igi";
        };
      }
      {
        name = "vim-cheatsheet";
        version = "1.0.0";
        src = fetchTarball {
          url =
            "https://github.com/reireias/vim-cheatsheet/archive/35a8d57e53abc210b1baa9377965ffe360b84334.tar.gz";
          sha256 = "0gjirzqrlr8vy4rlflx4kq3dbk5v2ihavw39y3q8ik8k27yx99d6";
        };
      }
      {
        name = "project-nvim";
        version = "1.0.0";
        src = fetchTarball {
          url =
            "https://github.com/ahmedkhalf/project.nvim/archive/71d0e23dcfc43cfd6bb2a97dc5a7de1ab47a6538.tar.gz";
          sha256 = "0jxxckfcm0vmcblj6fr4fbdxw7b5dwpr8b7jv59mjsyzqfcdnhs5";
        };
      }
      {
        name = "vim-sonictemplate";
        version = "1.0.0";
        src = fetchTarball {
          url =
            "https://github.com/mattn/vim-sonictemplate/archive/7a44ba848709ce6f4ea12e11e0de6664db69694c.tar.gz";
          sha256 = "0g862azpyk700qm96rlkd28clp6ngpmirawlxx88906qzbf8knp6";
        };
      }
    ] ++ singleton (mkVimPlugin' {
      pname = "denops-vim";
      version = "2.1.2";
      src = fetchTarball {
        url =
          "https://github.com/vim-denops/denops.vim/archive/refs/tags/v2.1.2.tar.gz";
        sha256 = "00szxrclnrq0wsdpwip6557yzizcc88f2c3kndpas2zzxjaix2bq";
      };
      dontBuild = true;
    });

  cocExtensions = [
    "coc-highlight"
    "coc-json"
    "coc-yaml"
    "coc-go"
    "coc-toml"
    "coc-floaterm"
    "coc-java"
    "coc-tsserver"
    "coc-pyright"
  ];
  extraLuaConfig = ''
    -- indent-blankline-nvim
    vim.opt.list = true
    vim.opt.listchars:append("space:⋅")
    vim.opt.listchars:append("eol:↴")
    require("indent_blankline").setup {
        show_end_of_line = true,
        space_char_blankline = " ",
    }

    -- project-nvim
    require("project_nvim").setup {
      silent_chdir = false,
    }

    -- tree-sitter
    require'nvim-treesitter.configs'.setup {
      ensure_installed = "maintained",
      sync_install = false,
      ignore_install = {},
      highlight = {
        enable = true,
        disable = { "c" },
        additional_vim_regex_highlighting = false,
      },
    }
    require'nvim-treesitter.configs'.setup {
      refactor = {
        smart_rename = {
          enable = true,
          keymaps = {
            smart_rename = "grr",
          },
        },
      },
    }
    require'treesitter-context'.setup{
      enable = true,
      throttle = true,
      max_lines = 0,
      patterns = {
        default = {
          'class',
          'function',
          'method',
          -- 'for',
          -- 'while',
          -- 'if',
          -- 'switch',
          -- 'case',
        },
      },
    }

    -- trouble
    require("trouble").setup {
      position = "bottom",
      height = 10,
      width = 50,
      icons = true,
      mode = "quickfix",
      fold_open = "",
      fold_closed = "",
      group = true,
      padding = true,
      action_keys = {
        close = "q",
        cancel = "<esc>",
        refresh = "r",
        jump = {"<cr>", "<tab>"},
        open_split = { "<c-x>" },
        open_vsplit = { "<c-v>" },
        open_tab = { "<c-t>" },
        jump_close = {"o"},
        toggle_mode = "m",
        toggle_preview = "P",
        hover = "K",
        preview = "p",
        close_folds = {"zM", "zm"},
        open_folds = {"zR", "zr"},
        toggle_fold = {"zA", "za"},
        previous = "k",
        next = "j"
      }
    }

    -- tab
    vim.g.bufferline = {
      animation = true,
      auto_hide = false,
      tabpages = true,
      closable = true,
      clickable = true,
      icons = true,
      icon_custom_colors = false,
      icon_separator_active = '▎',
      icon_separator_inactive = '▎',
      icon_close_tab = '',
      icon_close_tab_modified = '●',
      icon_pinned = '車',
      insert_at_end = true,
      insert_at_start = false,
      maximum_padding = 1,
      maximum_length = 30,
      semantic_letters = true,
      letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
      no_name_title = nil,
    }

    -- lightbulb
    -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

    -- gitsigns
    require('gitsigns').setup()

    -- stabilize
    require('stabilize').setup()

    -- todo-comments.nvim WIP
    require('todo-comments').setup()

    -- nvim-notify
    require('notify').setup()

    -- spaces.nvim
    require('specs').setup {
      show_jumps  = true,
      min_jump = 15,
      popup = {
        delay_ms = 0,
        inc_ms = 10,
        blend = 0,
        width = 10,
        winhl = "PMenu",
        fader = require('specs').linear_fader,
        resizer = require('specs').shrink_resizer
      },
      ignore_filetypes = {},
      ignore_buftypes = {
        nofile = true,
      },
    }
  '';

  extraConfig = ''
    " helplang
    " set helplang=ja

    " カラースキーム
    colorscheme ayu-mirage " termguicolors、backgroudも設定される

    " floating windowsの透過
    set pumblend=15

    " カーソル行可視化
    set cursorline

    """"""""""""
    " Commands "
    """"""""""""

    """"""""""""""""""
    " Global keybind "
    """"""""""""""""""

    inoremap <S-Tab> <C-d>

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
    " floaterm
    nnoremap <Leader>t :FloatermToggle<CR>
    " file search
    nnoremap <Leader><Leader>p :Files<CR>
    " choosewin
    nnoremap <Leader>- :ChooseWin<CR>
    nnoremap <Leader><Leader>- :ChooseWinSwap<CR>
    " easymotion
    " 1文字
    nmap <Leader>s <Plug>(easymotion-overwin-f)
    " 2文字
    nmap <Leader><Leader>s <Plug>(easymotion-overwin-f2)
    " カーソル下を検索
    map <Leader>j <Plug>(easymotion-j)
    " カーソル上を検索
    map <Leader>k <Plug>(easymotion-k)
    " ZEN
    nnoremap <Leader><Leader>z :Goyo<CR>

    " yank
    vnoremap <Leader>y :OSCYank<CR>

    " hilight
    nmap <Leader>m <Plug>(quickhl-manual-this)
    xmap <Leader>m <Plug>(quickhl-manual-this)
    nmap <Leader>M <Plug>(quickhl-manual-reset)
    xmap <Leader>M <Plug>(quickhl-manual-reset)

    " NERDTree
    nnoremap <Leader>b :NERDTreeTabsToggle<CR>

    " file (content) search
    nnoremap <Leader>ff :Telescope live_grep<CR>
    nnoremap <Leader>fp :Telescope find_files<CR>

    " quick run
    nnoremap <Leader>r :<C-U>QuickRun<CR>

    """"""""""""""
    " easymotion "
    """"""""""""""
    let g:EasyMotion_do_mapping = 0
    let g:EasyMotion_use_migemo = 1

    " easymotionでもsmartcase
    let g:EasyMotion_smartcase = 1

    """""""""""""""""
    " sonictemplate "
    """""""""""""""""
    let g:sonictemplate_vim_template_dir = [
    \ '${templates}'
    \]

    """"""""""
    " wilder "
    """"""""""
    function! s:wilder_init() abort
      call wilder#setup({
        \   'modes': [':', '/', '?'],
        \ })
      call wilder#set_option('pipeline', [
        \   wilder#branch(
        \     wilder#cmdline_pipeline({
        \       'language': 'lua',
        \       'fuzzy': 1,
        \       'fuzzy_filter': wilder#lua_fzy_filter(),
        \     }),
        \     wilder#python_search_pipeline({
        \       'pattern': wilder#python_fuzzy_pattern(),
        \       'sorter': wilder#python_difflib_sorter(),
        \       'engine': 're',
        \     }),
        \   ),
        \ ])
      let s:highlighters = [
        \   wilder#pcre2_highlighter(),
        \   has('nvim') ? wilder#lua_fzy_highlighter() : wilder#cpsm_highlighter(),
        \ ]
      let s:popupmenu_renderer = wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
        \   'border': 'rounded',
        \   'empty_message': wilder#popupmenu_empty_message_with_spinner(),
        \   'highlighter': s:highlighters,
        \   'left': [
        \     ' ',
        \     wilder#popupmenu_devicons(),
        \     wilder#popupmenu_buffer_flags({
        \       'flags': ' a + ',
        \       'icons': {'+': '', 'a': '', 'h': ''},
        \     }),
        \   ],
        \   'right': [
        \     ' ',
        \     wilder#popupmenu_scrollbar(),
        \   ],
        \ }))
      let s:lightline_renderer = wilder#wildmenu_renderer(
        \ wilder#wildmenu_lightline_theme({
        \   'hilights': {},
        \   'highlighter': s:highlighters,
        \   'separator': ' | ',
        \ }))

      let s:wildmenu_renderer = wilder#wildmenu_renderer({
        \   'highlighter': s:highlighters,
        \   'separator': ' · ',
        \   'left': [' ', wilder#wildmenu_spinner(), ' '],
        \   'right': [' ', wilder#wildmenu_index()],
        \ })

      call wilder#set_option('renderer', wilder#renderer_mux({
        \   ':': s:popupmenu_renderer,
        \   '/': s:lightline_renderer,
        \   'substitute': s:wildmenu_renderer,
        \ }))
    endfunction
    autocmd CmdlineEnter * ++once call s:wilder_init()

    " mouse有効化
    set mouse=a

    " 行数
    set number         " 表示
    set relativenumber " 相対表示

    " 短形選択の自由度を上げる
    set virtualedit=block

    " tabキーでspaceを入力する
    set expandtab
    set tabstop=4
    set shiftwidth=4

    " ファイル保管
    set wildmenu

    " バッファ切り替え時に保存不要に
    set hidden

    " モードをstatusに表示しない
    set noshowmode

    " better-whitespace
    let g:better_whitespace_enabled=1
    let g:strip_whitespace_on_save=1

    """"""""""""""""""""""
    " comfortable-motion "
    """"""""""""""""""""""
    let g:comfortable_motion_scroll_down_key = "j"
    let g:comfortable_motion_scroll_up_key = "k"
    noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
    noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

    " lightline
    set laststatus=2
    set showtabline=2
    let g:lightline#ale#indicator_checking = "\uf110"
    let g:lightline#ale#indicator_infos = "\uf129"
    let g:lightline#ale#indicator_warnings = "\uf071"
    let g:lightline#ale#indicator_errors = "\uf05e"
    let g:lightline#ale#indicator_ok = "\uf00c"
    let g:lightline = {
      \   'colorscheme': 'ayu_mirage',
      \   'active': {
      \     'left': [ [ 'mode', 'paste' ], [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \     'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
      \                [ 'fileformat', 'fileencoding', 'filetype'] ],
      \   },
      \   'component_function': {
      \     'filename': 'LightlineFilename',
      \     'gitbranch': 'gina#component#repo#branch',
      \   },
      \   'component_expand': {
      \     'buffers': 'lightline#bufferline#buffers',
      \     'linter_checking': 'lightline#ale#checking',
      \     'linter_infos': 'lightline#ale#infos',
      \     'linter_warnings': 'lightline#ale#warnings',
      \     'linter_errors': 'lightline#ale#errors',
      \     'linter_ok': 'lightline#ale#ok',
      \   },
      \   'component_type': {
      \     'buffers': 'tabsel',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \   },
      \ }
    function! LightlineFilename()
      return expand('%')
    endfunction

    " Goyo
    let g:goyo_width = 120
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!

    """"""""""""
    " floaterm "
    """"""""""""
    let g:floaterm_autoclose = 1

    " 検索
    set ignorecase                " 小文字のみの検索に限り小文字大文字の差を無視
    set smartcase
    set incsearch                 " インクリメンタルサーチ
    set hlsearch                  " 検索結果をハイライト
    nnoremap <silent> <ESC><ESC> :nohl<CR> " ESC2回押しでハイライトを消す

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

    " load lua
      lua <<EOF
        ${extraLuaConfig}
    EOF
          '';
  cocSettings = {
    suggest = {
      enablePreselect = true;
      enablePreview = true;
    };
    languagesever = {
      go = {
        command = "gopls";
        rootPatterns = [ "go.mod" ];
        filetypes = [ "go" ];
      };
      nix = {
        command = "rnix-lsp";
        filetypes = [ "nix" ];
      };
    };
    "java.jdt.ls.vmargs" =
      "-javaagent:${pkgs.lombok}/share/java/lombok.jar -Xbootclasspath/a:${pkgs.lombok}/share/java/lombok.jar";
    "java.autobuild.enabled" = false;
    "list.normalMappings" = { "<C-c>" = "do:exit"; };
    "list.insertMappings" = { "<C-c>" = "do:exit"; };
  };
in {
  home.packages = with pkgs;
    [ python39Packages.pynvim lombok ] ++ [ tree-sitter templates ];
  programs.neovim = {
    inherit plugins extraConfig;
    enable = true;
    package = pkgs.neovim-nightly;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    coc = {
      enable = false;
      settings = cocSettings;
    };
  };
}
