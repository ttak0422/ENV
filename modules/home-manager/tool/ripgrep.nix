{ config, pkgs, lib, ... }: {
  # grep clone
  home.packages = [ pkgs.ripgrep ];
}
