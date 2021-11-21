{ config, pkgs, lib, ... }: {
  imports = [ ./prelude.nix ./system ./window-manager ];
}
