{ config, pkgs, lib, ... }: {
  imports =
    [ ./dock.nix ./finder.nix ./keyboard.nix ./ng-global.nix ./trackpad.nix ];
}
