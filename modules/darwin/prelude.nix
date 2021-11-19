{ config, pkgs, lib, ... }: {
  services.nix-daemon.enable = true;
  environment.systemPackages = [
    # pkgs.hello
  ];
}
