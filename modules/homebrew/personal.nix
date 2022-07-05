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
      "font-jetbrains-mono"
      "iterm2"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keycastr"
      "kitty"
      "neovide"
      "tableplus"
      "visual-studio-code"
      "bitwarden"
    ];
  };
}
