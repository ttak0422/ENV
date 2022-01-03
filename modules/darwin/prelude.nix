{ config, pkgs, lib, ... }: {
  services.nix-daemon.enable = true;
  programs.zsh = {
    enable = true;
    promptInit = "";
  };
}
