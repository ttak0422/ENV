{ config, pkgs, lib, ... }: {
  home = {
    packages = with pkgs; [
      jdk
      # scala
      gradle
      maven
      sbt
      google-java-format
    ];
    file = { ".java/jdk".source = pkgs.jdk17; };
    sessionVariables = { JAVA_HOME = "$HOME/.java/jdk"; };
  };
}

