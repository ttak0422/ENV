{ config, pkgs, lib, ... }:
let
  inherit (builtins) mapAttrs;
  inherit (pkgs) writeScriptBin;
  inherit (lib) mapAttrsToList;

  defaultShell = "${pkgs.zsh}/bin/zsh";
  statusInterval = 60;
  resizeAmount = 5;
  normalSimbol = "‹:)";
  activeSimbol = "‹:)~";
  lBracketSimbol = "\\ue0b6";
  rBracketSimbol = "\\ue0b4";
  zoomSimbol = "";

  scripts = let
    shebang = ''
      #!${pkgs.bash}/bin/bash
    '';
    scriptDefinitions = {
      TMUX_LOA = ''
        uptime | awk -F "[:,]"  '{printf "%s %s %s\n",$(NF - 2),$(NF - 1), $NF}'
      '';
      TMUX_SINGLE_PANE = ''
        num=`tmux list-panes | wc -l`;
        if [[ 1 = $num ]]; then
          echo 0;
        else
          echo 1;
        fi
      '';
      TMUX_UPDATE_BORDER = ''
        zoomed=''${1:-0}
        num=`tmux list-panes | wc -l`;
        if [[ 1 = $num || 1 = $zoomed ]]; then
          tmux set pane-border-status off
        else
          tmux set pane-border-status top
        fi
      '';
      TMUX_KILL_PANE_AND_UPDATE_BORDER = ''
        tmux kill-pane
        num=`tmux list-panes | wc -l`;
        if [[ 1 = $num ]]; then
          tmux set pane-border-status off
        else
          tmux set pane-border-status top
        fi
      '';
    };
  in mapAttrs (k: v: writeScriptBin k (shebang + v)) scriptDefinitions;
  scriptPackages = mapAttrsToList (k: v: v) scripts;

  # 変更発生時向け
  borderUpdate = ''
    run-shell "${scripts.TMUX_UPDATE_BORDER}/bin/TMUX_UPDATE_BORDER #{window_zoomed_flag}"'';

  # 変更発生時向け (pane削除対応版)
  borderUpdate2 = ''
    run-shell "${scripts.TMUX_KILL_PANE_AND_UPDATE_BORDER}/bin/TMUX_KILL_PANE_AND_UPDATE_BORDER"'';

  # plugins for tmux
  tmuxPlugins = with pkgs.tmuxPlugins; [
    resurrect
    continuum
    better-mouse-mode
    copycat
    urlview
  ];

  prelude = ''
    set-option -g default-terminal screen-256color
    set-option -ga terminal-overrides ',xterm-256color:Tc'

    # mouse
    set-option -g mouse on

    # clipboard
    set -s set-clipboard on

    # bell
    set-option -g bell-action none

    # window: renumber
    set-option -g renumber-windows on
  '';

  bindings = ''
    # basic
    bind d detach-client
    bind : command-prompt
    # copy
    bind [ copy-mode
    # paste
    bind ] paste-buffer
    # clock
    bind t clock-mode
    # zoom
    bind z resize-pane -Z

    # session: create
    bind C-n command-prompt -I "" "new -s '%%'"
    # session: choose
    bind s choose-session
    # session: rename
    bind S command-prompt -I "#S" "rename-session '%%'"

    # window: create
    bind c new-window
    # window: close
    bind X confirm-before -p "kill-window #W? (y/n)" kill-window
    # window: choose
    bind w choose-window
    # window: rename
    bind W command-prompt -I "#W" "rename-window '%%'"
    # window: move
    bind 1 select-window -t :1
    bind 2 select-window -t :2
    bind 3 select-window -t :3
    bind 4 select-window -t :4
    bind 5 select-window -t :5
    bind 6 select-window -t :6
    bind 7 select-window -t :7
    bind 8 select-window -t :8
    bind 9 select-window -t :9
    bind 0 select-window -t :10
    bind -r , previous-window
    bind -r . next-window

    # pane: split
    bind | split-window -h -c '#{pane_current_path}'
    bind - split-window -v -c '#{pane_current_path}'
    # pane: close
    bind x confirm-before -p "kill-pane #T? (y/n)" kill-pane
    # pane: rename
    bind P command-prompt -I "" "select-pane -T '%%'"
    # pane: move
    bind -r h select-pane -L
    bind -r j select-pane -D
    bind -r k select-pane -U
    bind -r l select-pane -R
    # pane: resize
    bind -r H resize-pane -L ${toString resizeAmount}
    bind -r J resize-pane -D ${toString resizeAmount}
    bind -r K resize-pane -U ${toString resizeAmount}
    bind -r L resize-pane -R ${toString resizeAmount}
  '';

  statusline = ''
    set -g status off
  '';

  paneborder = ''
    set -g pane-active-border-style ""
    set -g pane-border-style ""
    set -g pane-border-format "#{?pane_active,${lBracketSimbol}#[reverse]#{?window_zoomed_flag,${zoomSimbol},} #S / #W / #T - (#(${scripts.TMUX_LOA}/bin/TMUX_LOA) #{?client_prefix,${activeSimbol},${normalSimbol}} #[default]${rBracketSimbol},}"
    set -g pane-border-status top
  '';

  session = ''
    # session: resurrect
    set -g @resurrect-strategy-nvim 'session'
    # session: continuum
    set -g @continuum-boot 'on'
    set -g @continuum-boot-options 'alacritty'
    set -g @continuum-save-interval '5' # minutes
    set -g @continuum-restore 'on'
  '';

  extraConfig = ''
    ${prelude}
    ${bindings}
    ${statusline}
    ${paneborder}
    ${session}
  '';
in {
  home.packages = scriptPackages;
  programs.tmux = {
    inherit extraConfig;
    enable = true;
    plugins = tmuxPlugins;
    sensibleOnTop = true;
    shortcut = "g";
    keyMode = "vi";
    customPaneNavigationAndResize = false;
    newSession = true;
    escapeTime = 1;
    baseIndex = 1;
    historyLimit = 5000;
  };
}
