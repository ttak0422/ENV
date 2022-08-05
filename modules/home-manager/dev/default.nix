{ config, pkgs, lib, ... }: {
  imports = [
    ./deno.nix
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
}
