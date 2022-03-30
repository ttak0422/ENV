{ config, pkgs, lib, ... }:
let
  inherit (lib.strings) fileContents;
  extraConfig = ''
    ${fileContents ./vim/tiny.vim}
  '';
in {
  programs.vim = {
    inherit extraConfig;
    enable = true;
    plugins = [ ];
  };
  # for copy
  home.file = { ".vimrc".text = extraConfig; };
}
