{ config, pkgs, lib, ... }:
let
  configPath = ".config/alacritty/alacritty.yml";
  fontSize = 14;
  padding = fontSize / 2;
  fontFamily = "JetBrains Mono";
  backgroundOpacity = 0.9;
  config = ''
    # ayu-mirage (neovim-ayuに寄せる)
    colors:
      primary:
        background: '#1F2430'
        foreground: '#CBCCC6'
      cursor:
        text: CellBackground
        cursor: '#528bff'
      selection:
        text: CellForeground
        background: '#707A8C'
      normal:
        black: '#1F2430'
        red: '#F28779'
        green: '#BAE67E'
        yellow: '#FFCC66'
        blue: '#5CCFE6'
        magenta: '#D4BFFF'
        cyan: '#95E6CB'
        white: '#CBCCC6'
      bright:
        8black: '#607080'
        9red: '#FF3333'
        0green: '#BAE67E'
        1yellow: '#FFCC66'
        2blue: '#5CCFE6'
        3magenta: '#D4BFFF'
        4cyan: '#95E6CB'
        5white: '#5C6773'
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
