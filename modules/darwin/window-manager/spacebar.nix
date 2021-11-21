{ config, pkgs, lib, ... }: {
  services.spacebar.enable = true;
  services.spacebar.package = pkgs.spacebar;
  services.spacebar.config = {
    position = "bottom";
    height = 26;
    spacing_left = 25;
    spacing_right = 15;
    text_font = ''"Hack Nerd Font:Bold:14.0"'';
    icon_font = ''"Hack Nerd Font:Bold:12.0"'';
    background_color = "0xff202020";
    foreground_color = "0xffa8a8a8";
    space_icon_color = "0xffffffff";
    battery_icon_color = "0xffd75f5f";
    clock_icon_color = "0xffa8a8a8";
    space_icon_strip = "・ ・ ・ ・ ・ ・ ・ ・ ・";
    space_icon = "・";
    clock_icon = " ";
    clock_format = ''"%m/%d %R"'';
    power_icon_strip = " ";
  };
}
