{ config, pkgs, lib, ... }:
let nixTool = with pkgs; [ nix-prefetch-git nix-prefetch-github ];
in {
  home.packages = with pkgs;
    [
      # WIP
      bat # cat clone
      bottom # system monitor
      commitizen # git commit helper
      coreutils-full # cat, ls, mv, wget, ...
      cue # data constraint language
      exa # ls clone
      fd # find clone
      figlet # ascii
      gnugrep
      gnused
      graphviz # dot
      hey # load test tool
      htop # top clone
      jq # JSON processor
      lazydocker # docker tui
      lazygit # git tui
      neofetch # system information tool
      nixfmt
      peco
      pkg-config # compile helper
      plantuml # uml
      pre-commit
      pwgen # password generator
      ranger # cui filer
      sqlite # db engine
      taskwarrior
      taskwarrior-tui
      tealdeer # tldr
      texlive.combined.scheme-full # TeX
      timewarrior
      tokei # code count
      viddy # watch
      wget # GNU Wget
      yq # JSON processor
      zoxide # fast cd
    ] ++ nixTool;
  imports = [ ./direnv.nix ./fzf.nix ./pet.nix ./ripgrep.nix ];
}
