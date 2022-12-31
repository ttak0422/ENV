{ config, pkgs, lib, ... }:
let
  configPath = ".config/alacritty/alacritty.yml";
  fontSize = 14;
  padding = fontSize / 2;
  fontFamily = "JetBrainsMono Nerd Font";
  backgroundOpacity = 0.9;
  config = ''
    colors:
      primary:
        background: '0xfafafa'
        foreground: '0x5b6672'
      normal:
        black: '0x000000'
        red: '0xf2590b'
        green: '0x76cc00'
        yellow: '0xf29717'
        blue: '0x41a5d9'
        magenta: '0x9965cc'
        cyan: '0x4dbf98'
        white: '0xc7c7c7'
      bright:
        black: '0x676767'
        red: '0xd6646a'
        green: '0xa3d900'
        yellow: '0xe7c446'
        blue: '0x6871ff'
        magenta: '0xa37acc'
        cyan: '0x56d9ad'
        white: '0xfeffff'
    env:
      TERM: screen-256color
    window:
      decorations: ${if pkgs.stdenv.isLinux then "none" else "buttonless"}
      padding:
        x: ${toString padding}
        y: ${toString padding}
      opacity: ${toString backgroundOpacity}
      dynamic_padding: false
    key_bindings:
      - { key: Minus, mods: Command|Shift, action: IncreaseFontSize } # JISキーボードで文字サイズを変更するため
      - { key: Backslash, mods: Alt, chars: "\x5c" } # JISキーボードのMacでバックスラッシュを入力するため
    font:
      size: ${toString fontSize}
      normal:
        family: ${fontFamily}
        style: Regular
      bold:
        family: ${fontFamily}
        style: Bold
      italic:
        family: ${fontFamily}
        style: Italic
  '';
in { home.file."${configPath}".text = config; }
