{ config, pkgs, lib, ... }:
let
  cfgPath = ".config/goneovim/settings.toml";
  cfg = ''
    [Editor]
    IgnoreSaveConfirmationWithCloseButton = true
    BorderlessWindow = true
    HideTitlebar = true
    # Transparent = 0.9
    WindowGeometryBasedOnFontmetrics = true

    FontFamily = "JetBrainsMono Nerd Font Mono"
    FontSize = 14

    ExtCmdline   = false
    ExtPopupmenu = true
    ExtTabline   = false
    ExtMessages  = false

    CachedDrawing = true
    CacheSize = 400

    DisableLigatures = false
    Clipboard = true
    HideMouseWhenTyping = true

    SmoothScroll = true
    SmoothScrollDuration = 300
    DisableHorizontalScroll = true

    DrawBorderForFloatWindow = false
    DrawShadowForFloatWindow = true
    DesktopNotifications = false

    ## GinitVim = '''
    ##  let g:hoge = 'fuga'
    ## '''
    # Ginitvim = ""

    [Cursor]
    SmoothMove = false
    Duration = 55

    [ScrollBar]
    Visible = false

    [MiniMap]
    Disable = true

    [SideBar]
    Visible = false

    RestoreSession = false
  '';
in { home.file."${cfgPath}".text = cfg; }
