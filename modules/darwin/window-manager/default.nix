{ config, pkgs, lib, ... }: {
  imports = [
    ./skhd.nix
    ./spacebar.nix
    # ./yabai.nix 
  ];
}
