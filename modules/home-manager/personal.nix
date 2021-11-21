{ config, pkgs, lib, ... }: {
  imports = [ ./application ./dev ./git ./shell ./tool ./vim ./window-manager ];
}
