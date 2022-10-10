{ pkgs, lib, stdenv }:

stdenv.mkDerivation {
  name = "ttak0422-templates";
  src = ./src;
  installPhase = ''
    mkdir $out
    cp -r ./* $out
  '';
}
