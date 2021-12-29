{ config, pkgs, lib, ... }: {
  imports = [
    ./deno.nix
    ./dotnet.nix
    ./go.nix
    ./jvm.nix
    ./nix.nix
    ./node.nix
    ./python.nix
  ];
}
