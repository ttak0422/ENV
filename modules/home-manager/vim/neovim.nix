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
  vimPlugins = with pkgs.vimPlugins;
    [
      # wildmenu
      {
        plugin = wilder-nvim;
        config = fileContents ./vim/wilder.vim;
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
