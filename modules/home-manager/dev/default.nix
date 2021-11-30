{ config, pkgs, lib, ... }: {
  imports = [ ./dotnet.nix ./go.nix ./jvm.nix ./node.nix ];
}
