{ config, pkgs, lib, ... }: {
  imports = [ ./prelude.nix ];
  homebrew = {
    brews = [ "lunchy" "qemu" "svn" ];
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
      "google-chrome"
      "displaylink"
      "firefox"
      "flutter"
      "font-roboto"
      "font-roboto-mono"
      "font-fira-code"
      "font-hack-nerd-font"
      "font-jetbrains-mono-nerd-font"
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
