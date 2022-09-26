{ config, pkgs, lib, ... }: {
  imports = [ ./prelude.nix ];
  homebrew = {
    brews = [ "lunchy" "svn" "emacs-plus@29" ];
    taps = [
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/core"
      "koekeishiya/formulae"
      "d12frosted/emacs-plus"
    ];
    casks = [
      "alacritty"
      "aquaskk"
      "cyberduck"
      "google-chrome"
      "displaylink"
      "firefox"
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
    ];
  };
}
