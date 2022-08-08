{ config, pkgs, lib, ... }: { home.packages = with pkgs; [ ghc ormolu stack ]; }

