{ config, pkgs, lib, ... }:
let
  cfgPath = ".config/goneovim/settings.toml";
  cfg = ''
    [Editor]
    IgnoreSaveConfirmationWithCloseButton = true
    BorderlessWindow = true
    # HideTitlebar = true

    # Transparent = 0.9
    WindowGeometryBasedOnFontmetrics = true

    ## Enable the ability to remember the last window geometry that was displayed
    ## and restore it at the next startup.
    RestoreWindowGeometry = false

    FontFamily = "JetBrainsMono Nerd Font Mono"
    FontSize = 14

    ## Neovim external UI features
    ## The following is the default value of goneovim.
    ## You can change the behavior of the GUI by changing the following boolean values.
    ## If you prefer the traditional Vim UI, set it to false for all.
    ## Also, `ExtMessages` is still experimental at this time and we don't recommend setting it to true if you want stability.
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

    # IgnoreFirstMouseClickWhenAppInactivated = false


    # Pattern that fills the diff background
    # Change the background pattern used for diff display.
    # This option allows you to use a visual effect pattern such as Dense, Diagonal Stripe instead of a regular solid pattern.
    # The available patterns are all Qt brush styles. For more information, See: https://doc.qt.io/qt-5/qbrush.html#details
    # // -- diffpattern enum --
    # // SolidPattern             1
    # // Dense1Pattern            2
    # // Dense2Pattern            3
    # // Dense3Pattern            4
    # // Dense4Pattern            5
    # // Dense5Pattern            6
    # // Dense6Pattern            7
    # // Dense7Pattern            8
    # // HorPattern               9
    # // VerPattern               10
    # // CrossPattern             11
    # // BDiagPattern             12
    # // FDiagPattern             13
    # // DiagCrossPattern         14
    # // LinearGradientPattern    15
    # // RadialGradientPattern    16
    # // ConicalGradientPattern   17
    # // TexturePattern           24
    # DiffAddPattern    = 1
    # DiffDeletePattern = 1
    # DiffChangePattern = 1

    ## Extra Dock menu option in MacOS
    ## You can add a menu with your own command options
    # [Editor.DockmenuActions]
    # hoge = "-u NONE"
    # fuga = "-u NORC"

    ## You can write a vimscript to be executed after goneovim starts,
    ## for example to disable the vimscript that Goneovim has embedded internally.
    ## GinitVim = '''
    ##  let g:hoge = 'fuga'
    ## '''
    # Ginitvim = ""


    [Cursor]
    SmoothMove = false
    Duration = 55

    [Popupmenu]
    ## neovim's popupmenu is made up of word, menu and info parts.
    ## Each of these parts will display the following information.
    ##   word:   the text that will be inserted, mandatory
    ##   menu:   extra text for the popup menu, displayed after "word"
    ##   info:   more information about the item, can be displayed in a preview window
    ## The following options specify whether to display a dedicated column in the popupmenu
    ## to display the long text displayed in the `info` part.
    # ShowDetail = true

    ## total number to display item
    # Total = 20

    ## width of `menu` column
    # MenuWidth = 400

    ## width of `info` column
    # InfoWidth = 1

    ## width of `detail` column
    # DetailWidth = 250

    ## Show digit number which can select item for popupmenu
    # ShowDigit = true


    [ScrollBar]
    Visible = false


    [MiniMap]
    Disable = true

    [SideBar]
    Visible = false

    RestoreSession = false

  '';
in { home.file."${cfgPath}".text = cfg; }
