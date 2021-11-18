{ config, pkgs, lib, ... }: { home.packages = with pkgs; [ dotnet-sdk ]; }
