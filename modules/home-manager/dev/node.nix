{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ nodePackages.npm yarn ];
}

