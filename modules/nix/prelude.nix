{ config, pkgs, lib, ... }: {
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    # Hack to support legacy worklows that use `<nixpkgs>` etc.
    nixPath = { nixpkgs = "$HOME/.config/nixpkgs/nixpkgs.nix"; };
    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };
    binaryCaches = [ "https://ttak0422.cachix.org" ];
    binaryCachePublicKeys =
      [ "ttak0422.cachix.org-1:nv62UZqX8/xe5jSyyTu4Z7tSpX1TiCYaYv89Xe7CFaM=" ];
  };
}
