{ config, pkgs, lib, ... }: {
  services.nix-daemon.enable = true;
  environment.systemPackages = [
    # pkgs.hello
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };
}
