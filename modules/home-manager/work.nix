{ config, pkgs, lib, ... }: {
  imports = [
    ./prelude.nix
    ./application
    ./dev/jvm.nix
    ./dev/deno.nix
    ./dev/node.nix
    ./dev/python.nix
    ./emacs
    ./git
    ./shell
    ./tmux
    ./tool
    ./vim
    ./window-manager
    ./utils/darwin.nix
  ];
  home.packages = with pkgs; [ cachix asciinema ];
}

