{ config, pkgs, lib, ... }: { home.packages = with pkgs; [ rnix-lsp ]; }
