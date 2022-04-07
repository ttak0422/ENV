{ pkgs, lib, stdenv }:
let
  fzy-lua-native = stdenv.mkDerivation {
    name = "fzy-lua-native";
    src = builtins.fetchTarball {
      url =
        "https://github.com/romgrk/fzy-lua-native/archive/aa00feb01128c4d279c8471898e15898e75d5df5.tar.gz";
      sha256 = "03sdsbw0sg8l1hi469zd8fdxi8aiwf5h3pq3dsyp2pprkj65sf95";
    };
    noBuild = true;
    installPhase = ''
      mkdir -p $out
      cp -r ./* $out
    '';
  };

  skk-dict = stdenv.mkDerivation {
    name = "skk-dict";
    src = builtins.fetchTarball {
      url =
        "https://github.com/skk-dev/dict/archive/c6e6a8822b673bfe3e7182f99cdffd1f7735a61e.tar.gz";
      sha256 = "1hafjawl2nyvcdm8lffz61ry1jsvyr0ssz4b5n95p6wjldq4l4ld";
    };
    noBuild = true;
    installPhase = ''
      mkdir -p $out
      cp -r ./* $out
    '';
  };

  # configuration requires write access...
  # jdt-language-server = stdenv.mkDerivation {
  #   name = "jdt-language-server";
  #   src = builtins.fetchurl {
  #     url =
  #       "https://download.eclipse.org/jdtls/milestones/1.7.0/jdt-language-server-1.7.0-202112161541.tar.gz";
  #     sha256 = "0ll5rgd8i8wfg2zz0ciapakl66qqaw344129qj72cyiixkgjh31g";
  #   };
  #   noBuild = true;
  #   sourceRoot = ".";
  #   installPhase = ''
  #     ls
  #     mkdir -p $out
  #     cp -r ./* $out
  #   '';
  # };
in { inherit fzy-lua-native skk-dict; }
