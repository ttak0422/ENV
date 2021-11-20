{ config, pkgs, lib, ... }: {
  nix = {
    # Hack to support legacy worklows that use `<nixpkgs>` etc.
    nixPath = { nixpkgs = "$HOME/.config/nixpkgs/nixpkgs.nix"; };
    extraOptions = ''
      experimental-features = flakes nix-command
    '';
  };
}
