{ config, pkgs, lib, ... }: {
  homebrew = {
    enable = true;
    autoUpdate = true;
    global = {
      brewfile = true;
      lockfiles = true;
    };
  };
}
