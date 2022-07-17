{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ nodejs nodePackages.npm yarn ];
}

