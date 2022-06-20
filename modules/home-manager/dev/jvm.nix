{ config, pkgs, lib, ... }: {
  home = {
    packages = with pkgs; [ jdk11 scala gradle maven sbt google-java-format ];
    file = { ".jdk/openjdk".source = pkgs.jdk11; };
    sessionVariables = { JAVA_HOME = "$HOME/.jdk/openjdk"; };
  };
}

