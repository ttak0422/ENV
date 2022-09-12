{ config, pkgs, lib, ... }:
let
  mod = "alt";
  resize = 40;
  densePadding = 12;
  sparsePaddingH = 100;
  sparsePaddingV = 20;
  terminal = (if pkgs.system == "aarch64-darwin" then
    "/opt/homebrew/bin"
  else
    "/usr/local/bin") + "/alacritty";
  config = ''
    # focus window
    ${mod} - h : yabai -m window --focus west
    ${mod} - j : yabai -m window --focus south
    ${mod} - k : yabai -m window --focus north
    ${mod} - l : yabai -m window --focus east
    # swap window
    shift + ${mod} - h : yabai -m window --swap west
    shift + ${mod} - j : yabai -m window --swap south
    shift + ${mod} - k : yabai -m window --swap north
    shift + ${mod} - l : yabai -m window --swap east
    # move display
    shift + ${mod} - 1 : yabai -m display --focus 1
    shift + ${mod} - 2 : yabai -m display --focus 2
    shift + ${mod} - 3 : yabai -m display --focus 3
    shift + ${mod} - 4 : yabai -m display --focus 4
    # move space
    ${mod} - 1 : yabai -m space --focus 1
    ${mod} - 2 : yabai -m space --focus 2
    ${mod} - 3 : yabai -m space --focus 3
    ${mod} - 4 : yabai -m space --focus 4
    ${mod} - 5 : yabai -m space --focus 5
    ${mod} - 6 : yabai -m space --focus 6
    ${mod} - 7 : yabai -m space --focus 7
    ${mod} - 8 : yabai -m space --focus 8
    ${mod} - 9 : yabai -m space --focus 9
    ${mod} - 0 : yabai -m space --focus 10
    # increase window size
    ${mod} - w : yabai -m window --resize top:0:-${toString resize}
    ${mod} - a : yabai -m window --resize left:-${toString resize}:0
    ${mod} - s : yabai -m window --resize bottom:0:${toString resize}
    ${mod} - d : yabai -m window --resize right:${toString resize}:0
    # decrease window size
    shift + ${mod} - w : yabai -m window --resize top:0:${toString resize}
    shift + ${mod} - a : yabai -m window --resize left:${toString resize}:0
    shift + ${mod} - s : yabai -m window --resize bottom:0:-${toString resize}
    shift + ${mod} - d : yabai -m window --resize right:-${toString resize}:0
    # toggle window fullscreen zoom
    ${mod} - z : yabai -m window --toggle zoom-fullscreen
    # float window
    ${mod} - f : yabai -m window --toggle float && yabai -m window --grid 10:10:2:1:7:8
    ${mod} - left : yabai -m window --toggle float && yabai -m window --grid 10:10:0:0:5:10
    ${mod} - right : yabai -m window --toggle float && yabai -m window --grid 10:10:5:0:5:10

    # [WIP] dense padding
    shift + ${mod} - x : yabai -m config top_padding ${
      toString densePadding
    } & \
      yabai -m config left_padding ${toString densePadding} & \
      yabai -m config right_padding ${toString densePadding} & \
      yabai -m config bottom_padding ${toString densePadding}

    # [WIP] sparse padding
    shift + ${mod} - c : yabai -m config top_padding ${
      toString sparsePaddingV
    } & \
      yabai -m config left_padding ${toString sparsePaddingH} & \
      yabai -m config right_padding ${toString sparsePaddingH} & \
      yabai -m config bottom_padding ${toString sparsePaddingV}

    # term
    ${mod} - t : ${terminal}

    # application
    ${mod} - c : ${CHROME}/bin/CHROME
    ${mod} - e : ${EMACS}/bin/EMACS

  '';
  SWAP_TERM = pkgs.writeScriptBin "SWAP_TERM" ''
    #!/usr/bin/osascript

    on checkFrontmost (name)
      tell application "System Events"
        try
          set n to name of first window of (first application process whose frontmost is true)
          return n = name
        on error
          return false
        end try
      end tell
    end checkFrontmost

    set term to "Alacritty"
    set termActive to checkFrontmost (term)
    delay 0.1
    tell application term to activate -- 高速化のため
    delay 0.1
    tell application "System Events"
      if termActive then
        set visible of application process term to false
      end if
    end tell

  '';
  CHROME = pkgs.writeScriptBin "CHROME" ''
    #!/usr/bin/osascript
    tell application "Google Chrome"
      make new window
    end tell
  '';
  EMACS = pkgs.writeScriptBin "EMACS" ''
    #!/usr/bin/osascript

    tell application "Emacs"
      make new window
    end tell
  '';
in {
  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = config;
  };
  environment.systemPackages = [ SWAP_TERM CHROME ];
}
