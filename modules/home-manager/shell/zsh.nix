{ config, pkgs, lib, ... }:
let shared = import ./shared.nix { shellType = "zsh"; };
in {
  home.packages = [ pkgs.starship ];
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    enableCompletion = false;
    shellAliases = shared.shellAliases;
    history = {
      size = 100000;
      save = 1000000;
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
    };
    initExtra = ''
      # Function Definitions
      function select-history() {
        BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
        CURSOR=$#BUFFER
      }

      # Function Binds
      zle -N select-history
      bindkey '^r' select-history

      # starship
      eval "$(starship init zsh)"
    '';
    plugins = [ ];
  };
}
