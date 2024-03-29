{ config, pkgs, lib, ... }: {
  imports = [
    ./deno.nix
    ./dhall.nix
    ./dotnet.nix
    ./elm.nix
    ./go.nix
    ./haskell.nix
    ./jvm.nix
    ./lua.nix
    ./nix.nix
    ./node.nix
    ./python.nix
    ./rust.nix
  ];
  home.packages = with pkgs; [ dart ];
}
