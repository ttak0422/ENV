{ config, pkgs, lib, ... }:
let
  inherit (builtins) attrValues;
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.strings) concatStringsSep;
  ignoreApps = [ "Finder" "zoom.us" "Docker*" "AnyConnect" "システム環境設定" ];
  config' = {
    mouse_follows_focus = "off";
    focus_follows_mouse = "off";
    window_shadow = "off";
    layout = "bsp";
    top_padding = 12;
    bottom_padding = 12;
    left_padding = 12;
    right_padding = 12;
    auto_balance = "on";
    mouse_modifier = "alt";
    mouse_action1 = "move";
    mouse_action2 = "resize";
    window_opacity = "off";
    active_window_opacity = "1.0";
    normal_window_opacity = "1.0";
    external_bar = "all:0:26";
  };
  gapSize = 12;
in {
  home.file.".config/yabai/yabairc".text = ''
    ${concatStringsSep "\n"
    (map (n: "yabai -m rule --add app='${n}' manage=off") ignoreApps)}
    ${concatStringsSep "\n" (attrValues
      (mapAttrs (k: v: "yabai -m config ${k} ${toString v}") config'))}
    yabai -m space --gap abs:${toString gapSize}
  '';
}
