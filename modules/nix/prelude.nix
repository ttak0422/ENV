{ config, pkgs, lib, ... }: {
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    # Hack to support legacy worklows that use `<nixpkgs>` etc.
    nixPath = { nixpkgs = "$HOME/.config/nixpkgs/nixpkgs.nix"; };
  };
}
