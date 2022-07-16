{ config, pkgs, lib, ... }:
{
  home.file.".wezterm.lua".text = builtins.readFile ./wezterm.lua;
}
