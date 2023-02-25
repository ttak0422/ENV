{ config, pkgs, lib, nix-filter, ... }:
let
  inherit (pkgs) callPackage;
  templates = callPackage ./templates { };
in with pkgs.vimPlugins; [{
  plugin = vim-sonictemplate.overrideAttrs (old: {
    src = nix-filter {
      root = vim-sonictemplate.src;
      exclude = [ "template/java" "template/make" ];
    };
  });
  startup = ''
    vim.g.sonictemplate_vim_template_dir = '${templates}'
  '';
  commands = [ "Template" ];
  delay = true;
}]
