{ config, pkgs, lib, userName, userEmail, ... }: {
  imports = [ ./tig.nix ];
  home.packages = with pkgs; [ ghq ];
  programs.git = {
    inherit userName userEmail;
    enable = true;
    lfs.enable = true;
    delta.enable = true;
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
    aliases = {
      ignore = ''
        ignore = !"f() { local s=$1; shift; \
        while [ $# -gt 0 ]; do s=\"$s,$1\"; shift; done;\
        curl -L \"https://www.gitignore.io/api/$s\"; }; f"
      '';
      # e.g. git delete-merged-branch develop
      # 参考 (https://qiita.com/hajimeni/items/73d2155fc59e152630c4)
      delete-merged-branch = ''
        !f () { git checkout $1; git branch --merged|egrep -v \
        '\\*|develop|main'|xargs git branch -d; };f
      '';
    };
  };
}
