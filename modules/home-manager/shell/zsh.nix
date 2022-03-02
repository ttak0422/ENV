{ config, pkgs, lib, ... }:
let
  shared = import ./shared.nix { shellType = "zsh"; };
  basicConfig = ''
    zstyle ':completion:*:default' menu select=2
    zstyle ':completion:*' list-separator '-->'
    zstyle ':completion:*:manuals' separate-sections true
  '';
  functionConfig = ''
      function select-history() {
      BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
      CURSOR=$#BUFFER
    }
    function pet-select() {
    BUFFER=$(pet search --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle redisplay
    }
  '';
  keybindConfig = let
    cfg = ''
      zle -N select-history
      bindkey "^r" select-history

      zle -N pet-select
      stty -ixon
      bindkey '^e' pet-select
    '';
  in ''
    function zvm_after_init() {
      ${cfg}
    }
  '';
  starshipConfig = ''
    [character]
    success_symbol = "[](bold green)"
    error_symbol = "[](bold red)"
    vicmd_symbol = "[](bold green)"
  '';
in {
  home.packages = with pkgs; [ ];
  programs.zsh = {
    defaultKeymap = "viins";
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    shellAliases = shared.shellAliases;
    history = {
      size = 100000;
      save = 1000000;
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
    };
    initExtra = ''
      ${basicConfig}
      ${functionConfig}
      ${keybindConfig}

            # https://qiita.com/ssh0/items/a9956a74bff8254a606a
            if [[ ! -n $TMUX ]]; then
              # get the IDs
              ID="`tmux list-sessions`"
              if [[ -z "$ID" ]]; then
                tmux new-session
              fi
              create_new_session="Create New Session"
              ID="$ID\n''${create_new_session}:"
              ID="`echo $ID | fzf --no-sort --prompt="Session > " | cut -d: -f1`"
              if [[ "$ID" = "''${create_new_session}" ]]; then
                tmux new-session
              elif [[ -n "$ID" ]]; then
                tmux attach-session -t "$ID"
              else
                :  # Start terminal normally
              fi
            fi
            '';
    sessionVariables = { EDITOR = "vim"; };
    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "zsh-bd";
        src = pkgs.zsh-bd;
        file = "share/zsh-bd/bd.plugin.zsh";
      }
    ];
  };
  programs.starship.enable = true;
  xdg.configFile."starship.toml".text = starshipConfig;
}
