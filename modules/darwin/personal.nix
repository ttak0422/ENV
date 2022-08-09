{ config, pkgs, lib, ... }: {
  imports = [ ./emacs ./prelude.nix ./system ./window-manager ];
  environment.systemPackages = with pkgs; [ hello cocoapods ];
}
