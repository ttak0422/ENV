{ config, pkgs, lib, ... }: {
  imports = [
    ./deno.nix
    ./elm.nix
    ./dotnet.nix
    ./go.nix
    ./jvm.nix
    ./lua.nix
    ./nix.nix
    ./node.nix
    ./python.nix
    ./rust.nix
  ];
}
