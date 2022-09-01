{ config, pkgs, lib, ... }:
let inherit (builtins) readFile;
in {
  programs.doom-emacs = {
    enable = false;
    doomPrivateDir = ./doom.d;
    emacsPackage = pkgs.emacs;
  };

  programs.emacs = { enable = false; };

  home.file.".emacs.d" = {
    source = ./emacs.d;
    recursive = true;
  };
}

