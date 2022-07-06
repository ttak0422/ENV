{ config, pkgs, lib, ... }: { home.packages = with pkgs; [ pkgs-stable.deno ]; }

