{ config, pkgs, lib, ... }: {
  imports = [ ./application ./dev ./shell ./tool ./vim ];
}
