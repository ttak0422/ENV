{ config, pkgs, lib, ... }: {
  imports = [
    ./dock.nix
    ./finder.nix
    ./keyboard.nix
    ./loginwindow.nix
    ./ng-global.nix
    ./trackpad.nix
  ];
}
