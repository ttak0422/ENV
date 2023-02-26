{ config, pkgs, lib, ... }:
let
  inherit (builtins) mapAttrs;
  inherit (pkgs) writeScriptBin;
  inherit (lib) mapAttrsToList;

  statusInterval = 60;
  resizeAmount = 5;
  activeSimbol = "";
  zoomOutSimbol = "";
  zoomInSimbol = "";
  darkBgColor = "#3F464B";
  darkFgColor = "DarkGrey";
  darkFgColor2 = "White";
  lightFgColor = "#2A2F33";
  leftStatusColor = "#61AFEF";

  scripts = let
    shebang = ''
      #!${pkgs.bash}/bin/bash
    '';
    scriptDefinitions = {
      TMUX_SESSION_NAME = ''
        DEFAULT="DEFAULT"
        NAME=$(tmux display-message -p "#S")
        if [ $NAME == "0" ]; then echo $DEFAULT; else echo $NAME; fi
      '';
      TMUX_PANE_NAME = ''
        NAME=$(tmux display-message -p "#T")
        if [ -z $NAME ]; then echo $(tmux display-message -p "#{pane_current_path}"); else echo $NAME; fi
      '';
      TMUX_USER = ''
        echo " $USER"
      '';
      TMUX_POMODORO = ''
        STATUS=`${pkgs.tmuxPlugins.tmux-pomodoro-plus}/share/tmux-plugins/tmux-pomodoro-plus/scripts/pomodoro.sh`
        if [ -z $STATUS ]; then echo " pomodoro"; else echo $STATUS; fi
      '';
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
    };
  in mapAttrs (k: v: writeScriptBin k (shebang + v)) scriptDefinitions;
  scriptPackages = mapAttrsToList (k: v: v) scripts;

  # plugins for tmux
  tmuxPlugins = with pkgs.tmuxPlugins; [
    resurrect
    continuum
    better-mouse-mode
    copycat
    urlview
    tmux-pomodoro-plus
  ];

  prelude = ''
    set -g default-terminal "tmux-256color"
    set -ag terminal-overrides ",xterm-256color:RGB"
    set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
    set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

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

    # session: create and fill empty title
    bind C-n command-prompt -I "" "new -s '%%'"\; select-pane -T ""
    # session: choose
    bind s choose-session
    # session: rename
    bind S command-prompt -I "#S" "rename-session '%%'"

    # window: create and fill empty title
    bind c new-window\; select-pane -T ""
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

    # pane: split and fill empty title
    bind | split-window -h -c '#{pane_current_path}'\; select-pane -T ""
    bind - split-window -v -c '#{pane_current_path}'\; select-pane -T ""
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

    # pomodoro (hack)
    bind p run-shell "${pkgs.tmuxPlugins.tmux-pomodoro-plus}/share/tmux-plugins/tmux-pomodoro-plus/scripts/pomodoro.sh toggle"
  '';

  zoom = "#{?window_zoomed_flag,${zoomInSimbol},${zoomOutSimbol}}";
  active = " #{?client_prefix,${activeSimbol},}";

  statusline = ''
    # pomodoro
    set -g @pomodoro_start 'p'
    set -g @pomodoro_on "#[fg=$text_red] "
    set -g @pomodoro_complete "#[fg=$text_green] "
    set -g @pomodoro_granularity 'on'
    set -g status-interval 1
    set -g @pomodoro_notifications 'on'
    set -g @pomodoro_sound 'on'

    # set -g status off

    set -g status on
    set -g status-position bottom
    set -g status-left-length 40
    set -g status-right-length 80
    # set-option -g status-interval ${toString statusInterval}
    set-option -g status-left "#[bg=${leftStatusColor},fg=${lightFgColor},bold] #(${scripts.TMUX_SESSION_NAME}/bin/TMUX_SESSION_NAME) "

    set-option -g status-justify "centre"
    set-window-option -g window-status-format "#[fg=${darkFgColor}] #I:#W #[default]"
    set-window-option -g window-status-current-format "#[fg=${darkFgColor2},bold] #I:#W #[default]"

    set -g status-right "#(${scripts.TMUX_POMODORO}/bin/TMUX_POMODORO) | #(${scripts.TMUX_USER}/bin/TMUX_USER) "

    set -g status-bg '${darkBgColor}'
    set -g status-fg '${darkFgColor}'
  '';

  paneborder = ''
    set -g pane-active-border-style ""
    set -g pane-border-style ""
    set -g pane-border-format "#{?pane_active, ${zoom} #(${scripts.TMUX_PANE_NAME}/bin/TMUX_PANE_NAME)${active},}"
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

    # set pane title to empty
    run 'tmux select-pane -T ""'
  '';
in {
  home.packages = scriptPackages;
  programs.tmux = {
    inherit extraConfig;
    enable = true;
    plugins = tmuxPlugins;
    sensibleOnTop = true;
    shortcut = "b";
    keyMode = "vi";
    customPaneNavigationAndResize = false;
    newSession = true;
    escapeTime = 1;
    baseIndex = 1;
    historyLimit = 5000;
  };
}
