{ config, pkgs, lib, ... }: {
  imports = [
    ./prelude.nix
    ./application
    ./dev
    ./git
    ./shell
    ./tmux
    ./tool
    ./vim
    ./emacs
    ./window-manager
  ];
  home.packages = with pkgs; [ cachix asciinema ];
}
