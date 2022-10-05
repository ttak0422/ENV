{ config, pkgs, lib, ... }: {
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    # Hack to support legacy worklows that use `<nixpkgs>` etc.
    nixPath = { nixpkgs = "$HOME/.config/nixpkgs/nixpkgs.nix"; };
    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };
    settings = {
      substituters = [
        "https://ttak0422.cachix.org"
        "https://cachix.org/api/v1/cache/emacs"
      ];
      trusted-public-keys = [
        "ttak0422.cachix.org-1:nv62UZqX8/xe5jSyyTu4Z7tSpX1TiCYaYv89Xe7CFaM="
        "emacs.cachix.org-1:b1SMJNLY/mZF6GxQE+eDBeps7WnkT0Po55TAyzwOxTY="
      ];
    };
  };
}
