{ config, pkgs, lib, ... }: {
  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };
}

