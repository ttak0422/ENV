{ config, pkgs, lib, ... }: {
  imports = [
    ./prelude.nix
    ./application
    ./dev/jvm.nix
    ./dev/deno.nix
    ./dev/node.nix
    ./dev/python.nix
    ./git
    ./shell
    ./tmux
    ./tool
    ./vim
    ./window-manager
  ];
  home.packages = with pkgs; [ cachix asciinema ];
}

