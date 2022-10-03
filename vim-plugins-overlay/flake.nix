{
  description = "vim-plugins-overlay";

  inputs = {
    tint-nvim = {
      url = "github:levouh/tint.nvim";
      flake = false;
    };
    zoomwintab-vim = {
      url = "github:troydm/zoomwintab.vim";
      flake = false;
    };
    nvim-treesitter = {
      url = "github:nvim-treesitter/nvim-treesitter";
      flake = false;
    };
    gitsigns-nvim = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
  };

  outputs = { self, ... }@inputs: {
    overlay = final: prev:
      let
        inherit (prev.vimUtils) buildVimPluginFrom2Nix;

        buildVitalityPlugin = name:
          buildVimPluginFrom2Nix {
            pname = name;
            version = "master";
            src = builtins.getAttr name inputs;
          };

        plugins =
          builtins.filter (name: name != "self") (builtins.attrNames inputs);
      in {
        vimPlugins = prev.vimPlugins // builtins.listToAttrs (map (name: {
          inherit name;
          value = buildVitalityPlugin name;
        }) plugins);
      };
  };
}
