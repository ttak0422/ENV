{ config, pkgs, lib, ... }: {
  imports = [ ];
  home.packages = with pkgs; [
    # kubernetes
    docker
    k9s
    minikube
    kubectl
  ];
}

