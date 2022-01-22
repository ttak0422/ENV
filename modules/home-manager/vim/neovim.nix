{ config, pkgs, lib, ... }:

let
  inherit (builtins) concatStringsSep map fetchTarball;
  inherit (lib.strings) fileContents;
  inherit (lib.lists) singleton;
  inherit (pkgs.vimUtils) buildVimPlugin;
  templates = pkgs.callPackage ./templates { };
  external = pkgs.callPackage ./external.nix { };
  wrap = txt: "'${txt}'";
  lua = luaCode: ''
      lua <<EOF
        ${luaCode}
    EOF
  '';
  readLua = path: lua (fileContents path);
  readVimScript = path: fileContents path;
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
    {
      plugin = nvim-treesitter;
      config = readLua ./lua/nvim-treesitter.lua;
    }
    {
      plugin = nvim-treesitter-context;
      config = readLua ./lua/nvim-treesitter-context.lua;
    }
    # {
    #   plugin = nvim-treesitter-textobjects;
    #   # ./lua/nvim-treesitter.lua
    # }
    # {
    #   plugin = nvim-treesitter-refactor;
    #   config = readLua ./lua/nvim-treesitter-refactor.lua;
    # }

    # diff
    diffview-nvim

    # lua
    plenary-nvim

    # nui
    nui-nvim

    # Windowの挙動を安定させる
    stabilize-nvim
    {
      plugin = stabilize-nvim;
      config = lua ''
        require('stabilize').setup()
      '';
    }

    # yank
    vim-oscyank

    # registers
    registers-nvim

    # support Nix
    vim-nix

    # colorscheme
    # {
    #   plugin = ayu-vim;
    #   config = ''
    #     let ayucolor="mirage"
    #   '';
    # }

    # {
    #   plugin = tokyonight-nvim;
    #   config = ''
    #     colorscheme tokyonight
    #   '';
    # }

    {
      plugin = mkVimPlugin {
        name = "material-nvim";
        version = "2022-01-19";
        src = fetchTarball {
          url =
            "https://github.com/marko-cerovac/material.nvim/archive/8abf1b1cdc75a3e1846ced199ee86a36b9a758c4.tar.gz";
          sha256 = "16ajmv2kwbnj8y40ysdfmqmikajpw63sqq7bqzx7nz0vv8vpiv8z";
        };
      };
      config = ''
        set termguicolors
        let g:material_style = 'darker'
        colorscheme material
      '' + (readLua ./lua/material-nvim.lua);
    }
    # {
    #   plugin = oceanic-next;
    #   config = ''
    #     set termguicolors
    #     syntax enable
    #     let g:oceanic_next_terminal_bold = 1
    #     let g:oceanic_next_terminal_italic = 1
    #     colorscheme OceanicNext
    #   '';
    # }

    {
      plugin = nvim-colorizer-lua;
      config = lua ''
        require 'colorizer'.setup()
      '';

    }

    # スクロールを物理シミュレーション
    {
      plugin = mkVimPlugin {
        name = "comfortable-motion-vim";
        version = "2021-01-10";
        src = fetchTarball {
          url =
            "https://github.com/yuttie/comfortable-motion.vim/archive/e20aeafb07c6184727b29f7674530150f7ab2036.tar.gz";
          sha256 = "13chwy7laxh30464xmdzjhzfcmlcfzy11i8g4a4r11m1cigcjljb";
        };
      };
      config = readVimScript ./vim/comfortable-motion.vim;
    }

    {
      plugin = mkVimPlugin {
        name = "specs-nvim";
        version = "2021-01-10";
        src = fetchTarball {
          url =
            "https://github.com/edluffy/specs.nvim/archive/e043580a65409ea071dfe34e94284959fd24e3be.tar.gz";
          sha256 = "1sg2i99ncx5j7al3mhwpnwyx1hila5gars0ak7q3n9yr4013i7dx";
        };
      };
      config = readLua ./lua/specs-nvim.lua;
    }
    # startify
    {
      plugin = vim-startify;
      config = readVimScript ./vim/startify.vim;
    }

    # 定番設定
    vim-sensible

    # スペース可視化
    vim-better-whitespace

    # インデント可視化
    {
      plugin = indent-blankline-nvim;
      config = readLua ./lua/indent-blankline-nvim.lua;
    }

    # yank可視化
    vim-highlightedyank

    # git
    {
      plugin = gitsigns-nvim;
      config = readLua ./lua/gitsigns.lua;
    }

    # vim向けeditorconfig
    editorconfig-vim

    {
      plugin = quick-scope;
      config = ''
        let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
      '';
    }

    {
      plugin = toggleterm-nvim;
      config = readLua ./lua/toggleterm-nvim.lua;
    }

    # zoom
    zoomwintab-vim

    {
      plugin = ale;
      config = readVimScript ./vim/ale.vim + ''
        let g:ale_java_javac_executable = "javac -cp ${pkgs.lombok}/share/java/lombok.jar"
      '';
    }

    {
      plugin = lualine-nvim;
      config = readLua ./lua/lualine-nvim.lua;
    }

    # {
    #   plugin = goto-preview;
    #   config = readLua ./lua/goto-preview.lua;
    # }

    # {
    #   plugin = lightline-vim;
    #   config = readVimScript ./vim/lightline-vim.vim;
    # }

    # lightline-ale
    # {
    #   plugin = lightline-bufferline;
    #   config = readVimScript ./vim/lightline-bufferline.vim;
    # }
    {
      plugin = mkVimPlugin' {
        pname = "nvim-lsp-installer";
        version = "2021-01-09";
        src = fetchTarball {
          url =
            "https://github.com/williamboman/nvim-lsp-installer/archive/f8e2821234cac696e27e286c009c3afae8c089ae.tar.gz";
          sha256 = "02c68b4z45mpaxcrg9q2nhawr25vhvz2kxh7d2f3k3xl983yzazp";
        };
        buildInputs = [ pkgs.git pkgs.cacert ];
      };
      config = readLua ./lua/nvim-lsp-installer.lua;
    }
    {
      plugin = nvim-lspconfig;
      # ./lua/nvim-lsp-installer.lua
    }
    {
      plugin = lsp_signature-nvim;
      config = readLua ./lua/lsp_signature-nvim.lua;
    }
    {
      plugin = mkVimPlugin {
        name = "lspsaga-nvim";
        version = "2021-01-10";
        src = fetchTarball {
          url =
            "https://github.com/tami5/lspsaga.nvim/archive/72eaf3544020db3da41d3813487329ae89512e9e.tar.gz";
          sha256 = "1baf13agnrsqykhy3r01fgj8vmyqv10v33j90rf4w1q02dn8zvgc";
        };
      };
      config = readLua ./lua/lspsaga-nvim.lua;
    }

    {
      plugin = mkVimPlugin' {
        pname = "neogen";
        version = "2022-01-14";
        src = fetchTarball {
          url =
            "https://github.com/danymat/neogen/archive/966d09146857af9ba23a4633dce0e83ad51f2b23.tar.gz";
          sha256 = "1xjc76r6n4x1q652f3hsxwqi6bm0g81fcl8na48inijawp5ic2zw";
        };
        dontBuild = true;
        installPhase = ''
          mkdir -p $out
          cp -r ./themes/* $out
        '';
      };
      config = lua ''
        require('neogen').setup {
          enabled = true
        }
      '';
    }

    # {
    #   plugin = mkVimPlugin {
    #     name = "virtual-types-nvim";
    #     version = "2022-01-14";
    #     src = {
    #       url = "https://github.com/jubnzv/virtual-types.nvim/archive/7d25c3130555a0173d5a4c6da238be2414144995.tar.gz";
    #       sha256 = "18dv3rzc5v8kfmw1brqagvbdz3pcfch4gzlbxl6kiv9x85yfdx98";
    #     };
    #   }
    # }

    {
      plugin = nvim-cmp;
      config = readLua ./lua/nvim-cmp.lua;
    }
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp-vsnip
    cmp-emoji
    lspkind-nvim # nvim-cmpでアイコン表示

    {
      plugin = vim-vsnip;
      config = "";
    }

    # whichkey
    which-key-nvim

    # telescope
    {
      plugin = telescope-nvim;
      config = readLua ./lua/telescope-nvim.lua;
    }
    telescope-fzf-native-nvim
    telescope-cheat-nvim

    # traces-vim
    # vim-closetag

    # vista
    vista-vim

    emmet-vim

    {
      # like easymotion
      plugin = hop-nvim;
      config = lua ''
        require'hop'.setup()
      '';
    }

    # nerdtree
    nerdtree
    nerdtree-git-plugin
    vim-nerdtree-tabs
    vim-nerdtree-syntax-highlight
    nvim-ts-rainbow

    # zen
    {
      plugin = mkVimPlugin {
        name = "zen-mode-nvim";
        version = "2021-01-10";
        src = fetchTarball {
          url =
            "https://github.com/folke/zen-mode.nvim/archive/f1cc53d32b49cf962fb89a2eb0a31b85bb270f7c.tar.gz";
          sha256 = "1fxkrny1xk69w8rlmz4x5msvqb8i8xvvl9csndpplxhkn8wzirdp";
        };
      };
      config = readLua ./lua/zen-mode.lua;
    }
    # zenの配色
    twilight-nvim

    # git
    gitsigns-nvim

    # cursor
    specs-nvim

    nvim-scrollview

    # command lineを見やすく
    {
      plugin = wilder-nvim;
      config = readVimScript ./vim/wilder.vim;
    }

    # hl
    nvim-hlslens

    # buffer
    nvim-bufdel

    # nortification
    # {
    #   plugin = nvim-notify;
    #   config = readLua ./lua/nvim-notify.lua;
    # }

    # todo comment
    {
      plugin = todo-comments-nvim;
      config = lua ''
        require("todo-comments").setup()
      '';
    }

    # package version
    package-info-nvim

    # action
    # {
    #   plugin = nvim-lightbulb;
    #   config = ''
    #     " autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
    #   '';
    # }

    {
      plugin = nvim-autopairs;
      # depends nvim-cmp
      config = lua ''
        require('nvim-autopairs').setup()
      '';
    }

    {
      plugin = vim-quickrun;
      config = ''
        let g:quickrun_config={'*': {'split': '''}}
        set splitbelow
      '';
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
    {
      plugin = mkVimPlugin {
        name = "project-nvim";
        version = "2021-01-10";
        src = fetchTarball {
          url =
            "https://github.com/ahmedkhalf/project.nvim/archive/71d0e23dcfc43cfd6bb2a97dc5a7de1ab47a6538.tar.gz";
          sha256 = "0jxxckfcm0vmcblj6fr4fbdxw7b5dwpr8b7jv59mjsyzqfcdnhs5";
        };
      };
      config = lua ''
        require("project_nvim").setup()
        require("telescope").load_extension("projects")
      '';
    }
    {
      plugin = trouble-nvim;
      config = readLua ./lua/trouble-nvim.lua;
    }
    {
      plugin = null-ls-nvim;
      config = readLua ./lua/null-ls-nvim.lua;
    }
    # wip...
    # https://github.com/chentau/marks.nvim
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

  extraConfig = ''
    " helplang
    " set helplang=ja

    " floating windowsの透過
    set pumblend=15

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
    " file search
    nnoremap <Leader><Leader>p :Files<CR>
    " choosewin
    nnoremap <Leader>- :ChooseWin<CR>
    nnoremap <Leader><Leader>- :ChooseWinSwap<CR>

    " hop.nvim
    nnoremap <Leader>s :HopChar1<CR>
    nnoremap <Leader><Leader>s :HopChar2<CR>
    nnoremap <Leader>j :HopLineAC<CR>
    nnoremap <Leader>k :HopLineBC<CR>

    " ZEN
    nnoremap <Leader><Leader>z :ZenMode<CR>

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
    nnoremap <Leader>fb :Telescope buffers<CR>

    " quick run
    nnoremap <Leader>r :<C-U>QuickRun<CR>

    " lspsage "
    nnoremap <silent><Leader>ca :Lspsaga code_action<CR>
    vnoremap <silent><Leader>ca :<C-U>Lspsaga range_code_action<CR>
    nnoremap <silent><Leader>rn :Lspsaga rename<CR>

    """""""""""""""""
    " sonictemplate "
    """""""""""""""""
    let g:sonictemplate_vim_template_dir = [
    \ '${templates}'
    \]

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

    """"""""""""
    " filetype "
    """"""""""""
    autocmd BufNewFile,BufRead *.fs,*.fsx,*.fsi set filetype=fsharp

    """"""""""
    " backup "
    """"""""""
    set nobackup
    set nowritebackup

    nnoremap <silent> <ESC><ESC> :nohl<CR> " ESC2回押しでハイライトを消す


    ${readVimScript ./vim/autocmd.vim}
    ${readVimScript ./vim/util.vim}
          '';
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

  };
}
