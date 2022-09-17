{ config, pkgs, lib, ... }:
let
  inherit (builtins) mapAttrs;
  inherit (pkgs) writeScriptBin;
  inherit (lib) mapAttrsToList;

  defaultShell = "${pkgs.zsh}/bin/zsh";
  statusInterval = 60;
  resizeAmount = 5;
  focusPane = "‹:)~❁";
  lBracketSimbol = "\\ue0b6";
  rBracketSimbol = "\\ue0b4";
  sessionSimbol = "\\uf53a";
  zoomSimbol = "\\uf519";
  loaSimbol = "\\uf91e";
  # vimで利用するもとと同じ
  colors = {
    yellow = "#ECBE7B";
    cyan = "#008080";
    darkblue = "#081633";
    green = "#98be65";
    orange = "#FF8800";
    violet = "#a9a1e1";
    magenta = "#c678dd";
    blue = "#51afef";
    red = "#ec5f67";
    white = "#ffffff";
    gray = "#969696";
  };
  colors = {

  };
  one = {
    bg = "#282c34";
    fg = "#abb2bf";
    yellow = "#e5c07b";
    blue = "#61afef";
    green = "#98c379";
    red = "#e06c75";
  };

  # helper script
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

  statusConfig = ''
    set-option -g status-interval ${toString statusInterval}

    # width
    set -g status-left-length 40
    set -g status-right-length 80

    # color
    set -g message-style bg=${colors.green},fg=${colors.darkblue}

    # status
    set-window-option -g status-style bg=default

    # status-left
    set -g status-left "#[bg=${colors.red},fg=${colors.darkblue}] ${sessionSimbol} #S #{?window_zoomed_flag,${zoomSimbol} ,}#[default]"

    # status-center
    set-option -g status-justify "centre"
    set-window-option -g window-status-format " #W "
    set-window-option -g window-status-current-format "#{?client_prefix,#[bg=${colors.green}],#[bg=${colors.blue}]}#[fg=${colors.darkblue},bold] #W #[default]"

    # status-right
    set -g status-right " ${loaSimbol}#(${scripts.TMUX_LOA}/bin/TMUX_LOA) "

    set -g status-position bottom
  '';
  # tmux.conf
  extraConfig = ''
    set-option -ga terminal-overrides ",screen-256color:Tc"

    #########
    # basic #
    #########

    bind d detach-client
    bind : command-prompt

    # copy
    bind [ copy-mode

    # paste
    bind ] paste-buffer

    # clock
    bind t clock-mode

    # zoom
    bind z resize-pane -Z\; ${borderUpdate}

    # mouse
    set-option -g mouse on

    # bell
    set-option -g bell-action none

    # run
    run-shell "${scripts.TMUX_UPDATE_BORDER}/bin/TMUX_UPDATE_BORDER #{window_zoomed_flag}";

    ##########
    # status #
    ##########
    set -g status off
    # {statusConfig}

    ############
    # sesssion #
    ############

    # session
    bind C-n command-prompt -I "" "new -s '%%'"

    # choose
    bind s choose-session

    # rename
    bind S command-prompt -I "#S" "rename-session '%%'"

    ##########
    # window #
    ##########

    # new
    bind c new-window\; ${borderUpdate}

    # close
    bind X confirm-before -p "kill-window #W? (y/n)" "${borderUpdate2}"

    # choose
    bind w choose-window

    # rename
    bind W command-prompt -I "#W" "rename-window '%%'"

    # select-window
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

    # move-window
    bind -r , previous-window
    bind -r . next-window

    # renumber
    set-option -g renumber-windows on

    # swap-windw
    bind -r < \
    swap-window -t -1\; \
      previous-window
    bind -r > \
    swap-window -t +1\; \
      next-window

    ########
    # pane #
    ########

    # split pane
    bind | split-window -h -c '#{pane_current_path}'\; ${borderUpdate}
    bind - split-window -v -c '#{pane_current_path}'\; ${borderUpdate}

    # close
    bind x confirm-before -p "kill-pane #W? (y/n)" "${borderUpdate2}"

    # rename
    bind P command-prompt -I "" "select-pane -T '%%'"

    # move-pane
    bind -r h select-pane -L
    bind -r j select-pane -D
    bind -r k select-pane -U
    bind -r l select-pane -R

    # resize-pane
    bind -r H resize-pane -L ${toString resizeAmount}
    bind -r J resize-pane -D ${toString resizeAmount}
    bind -r K resize-pane -U ${toString resizeAmount}
    bind -r L resize-pane -R ${toString resizeAmount}

    # pane-border
    set -g pane-active-border-style ""
    set -g pane-border-style ""
    set -g pane-border-format "#{?pane_active,${lBracketSimbol}#[reverse] #T ${focusPane} #[default]${rBracketSimbol},}"
    set -g pane-border-status off

    # resurrect
    set -g @resurrect-strategy-nvim 'session'
    # continuum
    set -g @continuum-boot 'on'
    set -g @continuum-boot-options 'alacritty'
    set -g @continuum-save-interval '5' # minutes
    set -g @continuum-restore 'on'

  '';
in {
  home.packages = scriptPackages;
  programs.tmux = {
    inherit extraConfig;
    enable = true;
    plugins = tmuxPlugins;
    sensibleOnTop = true;
    shortcut = "a";
    keyMode = "vi";
    customPaneNavigationAndResize = false;
    newSession = true;
    escapeTime = 1;
    baseIndex = 1;
    historyLimit = 5000;
    terminal = "screen-256color";
  };
}
