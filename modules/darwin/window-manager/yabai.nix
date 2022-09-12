{ config, pkgs, lib, ... }:
with lib; {
  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = false;
    config = {
      mouse_follows_focus = "off";
      focus_follows_mouse = "off";
      window_shadow = "off";
      layout = "bsp";
      top_padding = 12;
      bottom_padding = 12;
      left_padding = 12;
      right_padding = 12;
      auto_balance = "on";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      window_opacity = "off";
      active_window_opacity = "1.0";
      normal_window_opacity = "1.0";
    };
    # WIP: emacs起動後再起動が必要なことがある
    extraConfig = ''
      yabai -m rule --add app='Finder' manage=off
      yabai -m rule --add app='zoom.us' manage=off
      yabai -m rule --add app='Docker*' manage=off
      yabai -m rule --add app='AnyConnect' manage=off
      yabai -m rule --add app='Alacritty' manage=off
      yabai -m rule --add app='システム環境設定' manage=off
      yabai -m rule --add app=Emacs manage=on
      yabai -m space --gap abs:12
      yabai -m config mouse_modifier               alt
      yabai -m config mouse_action1                move
      yabai -m config mouse_action2                resize
      yabai -m config mouse_drop_action            swap
      yabai -m config external_bar all:0:26
    '';
  };
}
