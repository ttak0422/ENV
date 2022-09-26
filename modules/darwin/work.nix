{ config, pkgs, lib, ... }: {
  imports = [ ./emacs ./prelude.nix ./system ./window-manager ];
}

