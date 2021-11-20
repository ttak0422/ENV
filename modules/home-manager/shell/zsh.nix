{ config, pkgs, lib, ... }:
let shared = import ./shared.nix { shellType = "zsh"; };
in {
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    shellAliases = shared.shellAliases;
    plugins = [ ];
  };

}
