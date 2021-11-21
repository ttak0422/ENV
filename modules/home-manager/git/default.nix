{ config, pkgs, lib, userName, userEmail, ... }: {
  imports = [ ./tig.nix ];
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
    };
  };
}
