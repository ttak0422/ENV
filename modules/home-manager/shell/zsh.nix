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

      autoload -Uz edit-command-line
      zle -N edit-command-line
      bindkey '^xe' edit-command-line
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
    # todo refactor
    initExtra = ''
      ${basicConfig}
      ${functionConfig}
      ${keybindConfig}

      source <(kubectl completion zsh)
      export NEOVIDE_FRAMELESS=true
      export NEOVIDE_FRAME=buttonless
      export DOTNET_ROOT=$(dirname $(realpath $(which dotnet)))
      export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
      export PATH=$HOME/.dotnet/tools:$HOME/.local/bin:$PATH
      if [ -f /opt/homebrew/bin/brew ]; then
        export PATH=/opt/homebrew/bin:$PATH
      fi
    '';
    sessionVariables = {
      EDITOR = "vim";
      XDG_CACHE_HOME = "$HOME/.cache";
    };
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
  programs.starship = {
    enable = true;
    package = pkgs.starship;
  };
  xdg.configFile."starship.toml".text = starshipConfig;
}
