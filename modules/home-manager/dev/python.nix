{ config, pkgs, lib, ... }: { home.packages = with pkgs; [ python310 ]; }
