{ config, pkgs, lib, ... }: {
  system.defaults.dock = {
    appswitcher-all-displays = true;
    autohide = true;
    launchanim = false;
    mineffect = "suck";
    mouse-over-hilite-stack = true;
    orientation = "bottom";
    show-process-indicators = true;
    show-recents = false;
    showhidden = false;
    static-only = true;
  };
}
