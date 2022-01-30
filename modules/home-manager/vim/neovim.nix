{ config, pkgs, lib, ... }:

let
  inherit (builtins) concatStringsSep map fetchTarball;
  inherit (lib.strings) fileContents;
  inherit (lib.lists) singleton;
  inherit (pkgs.vimUtils) buildVimPlugin;
  templates = pkgs.callPackage ./templates { };
  external = pkgs.callPackage ./external.nix { };
  packerPackage = pkgs.callPackage ./lua/packer { };
  lua = luaCode: ''
    lua <<EOF
    ${luaCode}
    EOF
  '';
  readLua = path: lua (fileContents path);
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
      config = fileContents ./vim/wilder.vim;
    }

    # Linter
    # {
    #   plugin = ale;
    #   config = fileContents ./vim/ale.vim + ''
    #     let g:ale_java_javac_executable = "javac -cp ${pkgs.lombok}/share/java/lombok.jar"
    #   '';
    # }

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
      config = fileContents ./vim/comfortable-motion.vim;
    }
  ];
  nvimPlugins = with pkgs.vimPlugins; [
    # Luajit FFI
    external.fzy-lua-native

    # スクロールバー
    nvim-scrollview

    {
      plugin = packer-nvim;
      optional = true;
      config = readLua ./lua/init.lua;
    }
  ];

  extraConfig = ''
    " disable default plugin
    let g:did_load_filetypes = 1

    command! WhatHighlight :call util#syntax_stack()
    command! PackerInstall packadd packer.nvim | lua require('packer.plugins').install()
    command! PackerUpdate packadd packer.nvim | lua require('packer.plugins').update()
    command! PackerSync packadd packer.nvim | lua require('packer.plugins').sync()
    command! PackerClean packadd packer.nvim | lua require('packer.plugins').clean()
    command! PackerCompile packadd packer.nvim | lua require('packer.plugins').compile()

    ${fileContents ./vim/util.vim}

    " sonictemplate
    let g:sonictemplate_vim_template_dir = [ '${templates}' ]
  '';
in {
  home = {
    packages = with pkgs;
      [ gcc python39Packages.pynvim lombok ] ++ [ tree-sitter templates ];
    file = { ".config/nvim/lua/packer".source = packerPackage; };
  };
  programs.neovim = {
    inherit extraConfig;
    plugins = vimPlugins ++ nvimPlugins;
    enable = true;
    package = pkgs.neovim-nightly;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}
