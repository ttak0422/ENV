{ config, pkgs, lib, ... }: {
  imports = [
    ./application
    ./dev
    ./emacs
    ./git
    ./prelude.nix
    ./shell
    ./tmux
    ./zellij
    ./tool
    ./vim
    ./virtualization
    ./window-manager
    ./utils/darwin.nix
  ];
  home.packages = with pkgs; [ cachix asciinema ];
}
