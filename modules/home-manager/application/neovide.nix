{ config, pkgs, lib, ... }: {
  home.packages = with pkgs.pkgs-unstable; [ neovide ];
}
