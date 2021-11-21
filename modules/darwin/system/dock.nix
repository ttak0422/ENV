{ config, pkgs, lib, ... }: {
  system.defaults.dock = {
    autohide = true;
    mineffect = "suck";
    mouse-over-hilite-stack = true;
    orientation = "left";
    show-process-indicators = true;
    show-recents = false;
    showhidden = false;
    static-only = true;
  };
}
