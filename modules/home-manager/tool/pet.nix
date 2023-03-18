# snippet manager
{ config, pkgs, lib, ... }:

with lib;

let
  makeSnippet = { description, command, tag ? [ ], output ? "" }: ''
    [[snippets]]
        description = "${description}"
        command = "${command}"
        tag = [${strings.concatStringsSep ", " (map (x: ''"${x}"'') tag)}]
        output = "${output}"
  '';
  config' = ''
    [General]
        snippetfile = "${config.home.homeDirectory}/.config/pet/snippets.toml"
        editor = "vim"
        column = 40
        selectcmd = "fzf"
  '';
  snippets = strings.concatMapStringsSep "\n" makeSnippet [
    {
      description = "ping";
      command = "ping 8.8.8.8";
      tag = [ "network" "google" ];
      output = "sample snippet";
    }
    {
      description = "create local server";
      command = "python -m http.server <port=8080>";
      tag = [ "python" "server" ];
      output = "simple server";
    }
    {
      description = "filter & map";
      command = "find . -name '<RegExp=*.ext>' | xargs <Fn=foo>";
    }
    {
      description = "prefetch git";
      tag = [ "nix" ];
      command = "nix-prefetch-git --url '<Repository>'";
    }
    {
      description = "rust repl";
      tag = [ "rust" ];
      command = "evcxr";
    }
  ];
in {
  home = {
    packages = [ pkgs.pet ];
    file.".config/pet/config.toml".text = config';
    file.".config/pet/snippets.toml".text = snippets;
  };
  # fish
  programs.fish = {
    functions = {
      # https://github.com/otms61/fish-pet
      pet-select = ''
        set -l query (commandline)
        pet search --query "$query" $argv | read cmd
        commandline $cmd
      '';
      fish_user_key_bindings = "bind \\ce pet-select";
    };
  };

}
