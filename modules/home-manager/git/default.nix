{ config, pkgs, lib, userName, userEmail, ... }:
let
  core = {
    autocrlf = "false";
    editor = "nvim";
  };
  color = {
    ui = "auto";
    autocrlf = false;
  };
  ignores = [
    "*~"
    ".DS_Store"
    "Thumbs.db"
    "Thumbs.db:encryptable"
    ".idea"
    ".vscode/*"
    "!.vscode/settings.json"
    "!.vscode/tasks.json"
    "!.vscode/launch.json"
    "!.vscode/extensions.json"
    "*.code-workspace"
    ".ionide"
    ".vs"
    ".env"
    ".envrc"
  ];
  commitTemplate = ''


    # ==== Emojis ====
    # :art: when improving the format/structure of the code
    # :racehorse: when improving performance
    # :non-potable_water: when plugging memory leaks
    # :memo: when writing docs
    # :penguin: when fixing something on Linux
    # :apple: when fixing something on macOS
    # :checkered_flag: when fixing something on Windows
    # :bug: when fixing a bug
    # :fire: when removing code or files
    # :green_heart: when fixing the CI build
    # :white_check_mark: when adding tests
    # :lock: when dealing with security
    # :arrow_up: when upgrading dependencies
    # :arrow_down: when downgrading dependencies
    # :shirt: when removing linter warnings
  '';
  extraConfig = {
    inherit core color;
    commit.template = "~/.config/git/commit";
    init.defaultBranch = "main";
  };
in {
  imports = [ ./tig.nix ];
  home.packages = with pkgs; [ ghq ];
  programs.git = {
    inherit userName userEmail ignores extraConfig;
    enable = true;
    lfs.enable = true;
    delta.enable = true;
    aliases = {
      tags = "tag";
      ignore = "!f() { curl -L -s https://www.gitignore.io/api/$@ ;}; f";
      # e.g. git delete-merged-branch develop
      # 参考 (https://qiita.com/hajimeni/items/73d2155fc59e152630c4)
      delete-merged-branch = ''
        !f () { git checkout $1; git branch --merged|egrep -v \
        '\\*|develop|main'|xargs git branch -d; };f
      '';
    };
  };
  xdg.configFile = { "git/commit".text = commitTemplate; };
}
