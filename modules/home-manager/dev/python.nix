{ config, pkgs, lib, ... }: {
  home.packages = with pkgs.pkgs-stable;
    [
      # poetry
    ];
}
