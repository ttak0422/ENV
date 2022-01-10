{ config, pkgs, lib, ... }: {
  imports = [ ./prelude.nix ./system ./window-manager ];
  environment.systemPackages = with pkgs; [ hello cocoapods ];
}
