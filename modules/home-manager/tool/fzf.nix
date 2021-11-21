{ config, pkgs, lib, ... }: {
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f";
    fileWidgetCommand = "fd --type f";
  };
}
