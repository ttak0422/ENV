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
      "aquaskk"
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
      "tableplus"
      "visual-studio-code"
      # "bitwarden"
      # wait for m1 support
    ];
  };
}
