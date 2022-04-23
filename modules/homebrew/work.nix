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
      "font-fira-code"
      "font-hack-nerd-font"
      "font-jetbrains-mono"
      "iterm2"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keycastr"
      "tableplus"
      "visual-studio-code"
    ];
  };
}
