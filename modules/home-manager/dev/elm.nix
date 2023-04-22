{ config, pkgs, lib, ... }: {
  home.packages = with pkgs.elmPackages; [
    elm
    elm-language-server
    elm-test
    elm-format
  ];
}
