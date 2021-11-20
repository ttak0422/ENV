{ config, pkgs, lib, ... }:
let
  configPath = ".config/alacritty/alacritty.yml";
  fontSize = 16;
  padding = fontSize / 2;
  fontFamily = "Hack Nerd Font Mono";
  backgroundOpacity = 0.9;
  config = ''
    # Colors (One Dark - https://github.com/atom/atom/tree/master/packages/one-dark-syntax)
    colors:
      primary:
        background: '#282c34'
        foreground: '#abb2bf'
      cursor:
        text:       CellBackground
        cursor:     '#528bff' # syntax-cursor-color
      selection:
        text:       CellForeground
        background: '#3e4451' # syntax-selection-color
      normal:
        black:      '#5c6370' # mono-3
        red:        '#e06c75' # red 1
        green:      '#98c379'
        yellow:     '#e5c07b' # orange 2
        blue:       '#61afef'
        magenta:    '#c678dd'
        cyan:       '#56b6c2'
        white:      '#828997' # mono-2
    env:
      TERM: screen-256color
    window:
      decorations: ${if pkgs.stdenv.isLinux then "none" else "buttonless"}
      padding:
        x: ${toString padding}
        y: ${toString padding}
    background_opacity: ${toString backgroundOpacity}
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
