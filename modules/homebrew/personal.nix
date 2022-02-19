{ config, pkgs, lib, ... }: {
  imports = [ ./prelude.nix ];
  homebrew = {
    brews = [ "lunchy" ];
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
      "flutter"
      "font-fira-code"
      "font-hack-nerd-font"
      "iterm2"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keycastr"
      "kitty"
      "slack"
      "visual-studio-code"
      # wait for m1 support
      # "bitwarden"
    ];
  };
}
