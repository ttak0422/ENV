{ config, pkgs, lib, ... }: {
  imports = [ ./prelude.nix ];
  homebrew = {
    taps = [
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/core"
      "koekeishiya/formulae"
      "d12frosted/emacs-plus"
    ];
    brews = [ "lunchy" "qemu" "svn" "emacs-plus@29" ];
    casks = [
      "alacritty"
      "aquaskk"
      "cocoapods"
      "cyberduck"
      "google-chrome"
      "displaylink"
      "firefox"
      "flutter"
      "font-roboto"
      "font-roboto-mono"
      "font-roboto-mono-nerd-font"
      "font-fira-code"
      "font-hack-nerd-font"
      "font-jetbrains-mono-nerd-font"
      "font-hackgen-nerd"
      "iterm2"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keycastr"
      "kitty"
      "neovide"
      "tableplus"
      "visual-studio-code"
      "bitwarden"
      "processing"
      "wezterm"
    ];
  };
}
