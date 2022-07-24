{ config, pkgs, lib, ... }: {
    programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
  };
}

