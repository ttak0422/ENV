{ config, pkgs, lib, ... }: {
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}
