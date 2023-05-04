{ config, pkgs, lib, ... }: {
  imports =
    [ ./alacritty.nix ./kitty.nix ./wezterm.nix ./goneovim.nix ./neovide.nix ];
}
