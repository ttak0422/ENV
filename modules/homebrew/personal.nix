{ config, pkgs, lib, ... }: {
  imports = [ ./prelude.nix ];
  homebrew = {
    brews = [
      "lunchy"
      "yabai" # wip...
    ];
    taps = [ "homebrew/core" "homebrew/cask" "homebrew/cask-fonts" ];
    casks = [
      "alacritty"
      "cyberduck"
      "firefox"
      "font-fira-code"
      "font-hack-nerd-font"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keycastr"
      "slack"
      "visual-studio-code"
      # wait for m1 support
      # "bitwarden"
    ];
  };
}
