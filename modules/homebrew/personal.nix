{ config, pkgs, lib, ... }: {
  imports = [ ./prelude.nix ];
  homebrew = {
    brews = [
      "lunchy"
      "yabai" # wip...
    ];
    taps = [
      "homebrew/cask-fonts"
      "homebrew/cask"
      "homebrew/core"
      "koekeishiya/formulae"
    ];
    casks = [
      "alacritty"
      "cyberduck"
      "firefox"
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
