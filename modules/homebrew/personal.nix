{ config, pkgs, lib, ... }: {
  imports = [ ./prelude.nix ];
  homebrew = {
    taps = [
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/cask-fonts"
      "homebrew/core"
      "koekeishiya/formulae"
    ];
    brews = [ "lunchy" "qemu" "svn" ];
    casks = [
      "alacritty"
      "aquaskk"
      "bitwarden"
      "cocoapods"
      "cyberduck"
      "displaylink"
      "firefox"
      "flutter"
      "font-fira-code"
      "font-hack-nerd-font"
      "font-hackgen-nerd"
      "font-jetbrains-mono-nerd-font"
      "font-plemol-jp-nfj"
      "font-roboto"
      "font-roboto-mono"
      "font-roboto-mono-nerd-font"
      "google-chrome"
      "iterm2"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keycastr"
      "kitty"
      "neovide"
      "onedrive"
      "processing"
      "tableplus"
      "visual-studio-code"
      "wezterm"
    ];
  };
}
