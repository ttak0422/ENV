{ pkgs, lib, stdenv }: {
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
  migemo-dict = pkgs.fetchzip {
    name = "migemo-dict";
    url =
      "https://github.com/oguna/migemo-dict-latest/releases/download/v2021-05-07/migemo-dict.zip";
    sha256 = "sha256-40fuRCmRL9FABt4jrhTp1S/FW9fiRLieEQwcS3UKIyE=";
  };
}

