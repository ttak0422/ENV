{ config, pkgs, lib, ... }: {
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    global = {
      brewfile = true;
      lockfiles = true;
    };
  };
}
