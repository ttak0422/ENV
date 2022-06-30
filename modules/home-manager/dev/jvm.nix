{ config, pkgs, lib, ... }: {
  home = {
    packages = with pkgs; [ jdk scala gradle maven sbt google-java-format ];
    file = { ".jdk/openjdk".source = pkgs.jdk; };
    sessionVariables = { JAVA_HOME = "$HOME/.jdk/openjdk"; };
  };
}

