{ config, pkgs, lib, ... }: {
  programs = {
    zsh.enable = true;
    bash.enable = true;
  };
  xdg.configFile = {
    "nix/nix.conf".text = ''
      experimental-features = nix-command flakes
    '';
  };
}

