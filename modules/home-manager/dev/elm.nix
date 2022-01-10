{ config, pkgs, lib, ... }: {
  home.packages = with pkgs.pkgs-stable.elmPackages; [
    elm
    elm-language-server
    elm-test
    elm-format
  ];
}
