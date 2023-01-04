{ pkgs, lib, ... }:
let inherit (builtins) readFile;
in with pkgs.vimPlugins; [{
  plugin = nvim-dap;
  depends = [ nvim-treesitter nvim-dap-ui nvim-dap-virtual-text nvim-dap-go ];
  dependsAfter = [ nvim-dap-virtual-text ];
  startup = readFile ./keymap.lua;
  config = readFile ./dap.lua;
  modules = [ "dap" "dapui" ];
  extraPackages = with pkgs; [ delve ];
  delay = true;
}]
