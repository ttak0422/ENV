{ pkgs, lib, stdenv }:

stdenv.mkDerivation {
  name = "ttak0422-packer";
  src = ./.;
  installPhase = ''
    mkdir $out
    cp -r ./* $out
  '';
}
