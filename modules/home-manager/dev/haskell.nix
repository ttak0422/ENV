{ config, pkgs, lib, ... }: {
  home.packages = with pkgs.pkgs-stable; [ ghc ormolu stack cabal-install ];
}
