{ config, pkgs, lib, ... }:

let
  inherit (builtins) concatStringsSep map fetchTarball;
  inherit (lib.strings) fileContents;
  inherit (lib.lists) singleton;
  inherit (pkgs.vimUtils) buildVimPlugin;
  templates = pkgs.callPackage ./templates { };
  external = pkgs.callPackage ./external.nix { };
  lua = luaCode: ''
    lua <<EOF
    ${luaCode}
    EOF
  '';
  packerConfig = cfg:
    lua ''
      vim.cmd[[packadd packer.nvim]]
      require'packer'.startup(function()
      ${cfg}
      end)
    '';
  # [Path] -> String
  readFiles = paths:
    concatStringsSep "\n" (map (path: fileContents path) paths);
  readLua = path: lua (fileContents path);
  readVimScript = path: fileContents path;
  mkVimPlugin = cfg:
    buildVimPlugin {
      pname = cfg.name;
      version = cfg.version;
      src = cfg.src;
    };
  mkVimPlugin' = buildVimPlugin;
  vimPlugins = with pkgs.vimPlugins; [
    # 定番設定
    vim-sensible

    # Nixサポート
    vim-nix

    # スペース可視化 & 除去
    vim-better-whitespace

    # yank可視化
    vim-highlightedyank

    # editorconfig
    editorconfig-vim

    # ハイライト
    nvim-hlslens

    # ベターQuickFix
    nvim-bqf

    # f, t 移動のサポート
    {
      plugin = quick-scope;
      config = ''
        let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
      '';
    }

    # ペインのズーム
    {
      plugin = zoomwintab-vim;
      config = ''
        let g:zoomwintab_remap = 0
        nnoremap <C-w>z :ZoomWinTabToggle<CR>
      '';
    }

    # ペインのリサイズ
    {
      plugin = buildVimPlugin {
        pname = "winresizer";
        version = "1.1.1";
        src = fetchTarball {
          url =
            "https://github.com/simeji/winresizer/archive/refs/tags/v1.1.1.tar.gz";
          sha256 = "08mbhckjawyawjgii8qqsdzvqvs8d0vra0fab75cdi4x08f0az94";
        };
      };
    }

    # wildmenu
    {
      plugin = wilder-nvim;
      config = readVimScript ./vim/wilder.vim;
    }

    # Linter
    {
      plugin = ale;
      config = readVimScript ./vim/ale.vim + ''
        let g:ale_java_javac_executable = "javac -cp ${pkgs.lombok}/share/java/lombok.jar"
      '';
    }

    # スクロールを滑らかに
    {
      plugin = buildVimPlugin {
        pname = "comfortable-motion-vim";
        version = "2022-01-10";
        src = fetchTarball {
          url =
            "https://github.com/yuttie/comfortable-motion.vim/archive/e20aeafb07c6184727b29f7674530150f7ab2036.tar.gz";
          sha256 = "13chwy7laxh30464xmdzjhzfcmlcfzy11i8g4a4r11m1cigcjljb";
        };
      };
      config = readVimScript ./vim/comfortable-motion.vim;
    }
  ];
  nvimPlugins = with pkgs.vimPlugins; [
    # Luajit FFI bindings to FZY
    external.fzy-lua-native

    # スクロールバー
    nvim-scrollview
    # 構文解析
    {
      plugin = nvim-treesitter;
      config = readLua ./lua/nvim-treesitter.lua;
    }
    {
      plugin = nvim-treesitter-context;
      config = readLua ./lua/nvim-treesitter-context.lua;
    }
  ];
  packerPlugins = singleton {
    plugin = pkgs.vimPlugins.packer-nvim;
    optional = true;
    config = packerConfig (readFiles [
      ./lua/packer/alpha-nvim.lua
      ./lua/packer/bufferline-nvim.lua
      ./lua/packer/diffview-nvim.lua
      ./lua/packer/gitsigns-nvim.lua
      ./lua/packer/hop-nvim.lua
      ./lua/packer/indent-blanklin-nvim.lua
      ./lua/packer/lsp_signature-nvim.lua
      ./lua/packer/lspkind.lua
      ./lua/packer/lspsaga-nvim.lua
      ./lua/packer/lualine-nvim.lua
      ./lua/packer/neogen.lua
      ./lua/packer/nvim-autopairs.lua
      ./lua/packer/nvim-bufdel.lua
      ./lua/packer/nvim-cmp.lua
      ./lua/packer/nvim-colorizer-lua.lua
      ./lua/packer/nvim-lsp-installer.lua
      ./lua/packer/nvim-treesitter-context.lua
      ./lua/packer/nvim-treesitter.lua
      ./lua/packer/plenary-nvim.lua
      ./lua/packer/project-nvim.lua
      ./lua/packer/registers-nvim.lua
      ./lua/packer/sidebar-nvim.lua
      ./lua/packer/specs-nvim.lua
      ./lua/packer/stabilize-nvim.lua
      ./lua/packer/telescope-nvim.lua
      ./lua/packer/todo-comments-nvim.lua
      ./lua/packer/toggleterm-nvim.lua
      ./lua/packer/tokyonight-nvim.lua
      ./lua/packer/trouble-nvim.lua
      ./lua/packer/vim-choosewin.lua
      ./lua/packer/vim-oscyank.lua
      ./lua/packer/vim-quickhl.lua
      ./lua/packer/vim-sonic-template.lua
      ./lua/packer/vim-vsnip.lua
      ./lua/packer/vimdoc-ja.lua
      ./lua/packer/zen-mode-nvim.lua
    ]);
  };
  plugins = (with pkgs.vimPlugins; [
    # whichkey
    which-key-nvim

    emmet-vim

    # nerdtree
    nerdtree
    nerdtree-git-plugin
    vim-nerdtree-tabs
    vim-nerdtree-syntax-highlight
    # debug
    {
      plugin = vimspector;
      config = ''
        let g:vimspector_enable_mappings = 'HUMAN'
      '';
    }
    {
      plugin = null-ls-nvim;
      config = readLua ./lua/null-ls-nvim.lua;
    }
  ])
  # wip...
    ++ map mkVimPlugin [{
      name = "vim-choosewin";
      version = "1.5.0";
      src = fetchTarball {
        url =
          "https://github.com/t9md/vim-choosewin/archive/refs/tags/v1.5.tar.gz";
        sha256 = "1lqj0yxkpr007y867b9lmxw7yrfnsnq603bsa2mpbalhv5xgayif";
      };
    }] ++ singleton (mkVimPlugin' {
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
    " colorscheme "
    let g:tokyonight_style = 'night'
    colorscheme tokyonight

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


    " ZEN
    nnoremap <Leader><Leader>z :ZenMode<CR>

    " hilight
    nmap <Leader>m <Plug>(quickhl-manual-this)
    xmap <Leader>m <Plug>(quickhl-manual-this)
    nmap <Leader>M <Plug>(quickhl-manual-reset)
    xmap <Leader>M <Plug>(quickhl-manual-reset)

    " NERDTree
    nnoremap <Leader>b :NERDTreeTabsToggle<CR>


    " quick run
    nnoremap <Leader>r :<C-U>QuickRun<CR>

    " lspsage "

    """""""""""""""""
    " sonictemplate "
    """""""""""""""""
    let g:sonictemplate_vim_template_dir = [ '${templates}' ]

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
    inherit extraConfig;
    plugins = vimPlugins ++ nvimPlugins ++ packerPlugins;
    enable = true;
    package = pkgs.neovim-nightly;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;

  };
}
