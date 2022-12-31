{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ nodePackages.npm nodejs yarn ];
}
