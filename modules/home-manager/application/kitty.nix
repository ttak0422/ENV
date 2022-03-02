{ config, pkgs, lib, ... }:
let
  themes = pkgs.stdenv.mkDerivation {
    name = "kitty-themes";
    src = builtins.fetchTarball {
      url =
        "https://github.com/dexpota/kitty-themes/archive/fca3335489bdbab4cce150cb440d3559ff5400e2.tar.gz";
      sha256 = "11dgrf2kqj79hyxhvs31zl4qbi3dz4y7gfwlqyhi4ii729by86qc";
    };
    noBuild = true;
    installPhase = ''
      mkdir -p $out
      cp -r ./themes/* $out
    '';
  };

  config' = ''
    font_family Hack Nerd Font Mono Bold
    bold_font        auto
    italic_font      auto
    bold_italic_font auto
    hide_window_decorations yes
    window_padding_width 3

    include ./theme.conf
    hide_window_decorations ${
      if pkgs.stdenv.isLinux then "yes" else "titlebar-only"
    }

    clear_all_shortcuts yes
    map cmd+minus change_font_size all -2.0
    map cmd+shift+minus change_font_size all +2.0
    map cmd+c copy_to_clipboard
    map cmd+v paste_from_clipboard
    map cmd+w close_os_window
  '';
in {
  home.packages = [ themes ];
  programs.kitty = {
    # WIP
    enable = false;
  };
  xdg.configFile = {
    "kitty/kitty.conf".text = config';
    "kitty/theme.conf".source = "${themes}/ayu_mirage.conf";
  };
}
