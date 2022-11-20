{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ go gore gopls go-tools ];
}
