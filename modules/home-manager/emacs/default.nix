{ config, pkgs, lib, ... }: {
  programs.doom-emacs = {
    enable = false;
    doomPrivateDir = ./doom.d;
  };
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraConfig = ''
      ;; no titlebar
      (add-to-list 'default-frame-alist '(undecorated . t))

      ;; bell
      (setq visible-bell t)

      (menu-bar-mode t)
    '';
  };
}

