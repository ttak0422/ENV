{ config, pkgs, lib, ... }:
let
  brewPrefix = if pkgs.system == "aarch64-darwin" then
    "/opt/homebrew/bin"
  else
    "/usr/local/bin";
in {
  environment.shellInit = ''
    eval "$(${brewPrefix}/brew shellenv)"
  '';
  homebrew = {
    enable = true;
    brewPrefix = brewPrefix;
    global = {
      brewfile = true;
      noLock = true;
    };
  };
}
