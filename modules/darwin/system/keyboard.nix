{ config, pkgs, lib, ... }: {
  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
    defaults.NSGlobalDomain = {
      InitialKeyRepeat = 10;
      KeyRepeat = 2;
    };
  };
}
