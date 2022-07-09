{ config, pkgs, lib, ... }:
let
  nixTool = with pkgs; [
    nix-prefetch-git
    nix-prefetch-github
  ];
in {
  home.packages = with pkgs.pkgs-stable; [
    bat # cat clone
    coreutils-full # cat, ls, mv, wget, ...
    exa # ls clone
    fd # find clone
    figlet # ascii
    gnugrep
    gnused
    hey # load test tool
    htop # top clone
    jq # JSON processor
    lazydocker # docker tui
    lazygit # git tui
    neofetch # system information tool
    nixfmt
    peco
    pkg-config # compile helper
    pwgen # password generator
    ranger # cui filer
    wget # GNU Wget
    yq # JSON processor
  ] ++ nixTool;
  imports = [ ./direnv.nix ./fzf.nix ./pet.nix ./ripgrep.nix ];
}
