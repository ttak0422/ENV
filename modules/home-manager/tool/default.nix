{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    bat # cat clone
    coreutils-full # cat, ls, mv, wget, ...
    direnv # env switcher
    exa # ls clone
    fd # find clone
    hey # load test tool
    htop # top clone
    jq # JSON processor
    neofetch # system information tool
    nixfmt
    pkg-config # compile helper
    pwgen # password generator
    ranger # cui filer
    wget # GNU Wget
    yq # JSON processor
  ];
  imports = [ ./fzf.nix ./pet.nix ./ripgrep.nix ];
}
