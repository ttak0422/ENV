{ config, pkgs, lib, ... }: {
  imports = [ ./prelude.nix ];
  taps = [
    "homebrew/cask"
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
    "homebrew/core"
    "koekeishiya/formulae"
  ];
  casks = [
    "alacritty"
    "cyberduck"
    "displaylink"
    "firefox"
    "font-fira-code"
    "font-hack-nerd-font"
    "iterm2"
    "jetbrains-toolbox"
    "karabiner-elements"
    "keycastr"
    "tableplus"
    "visual-studio-code"
  ];
}
