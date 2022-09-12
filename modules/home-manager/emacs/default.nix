{ config, pkgs, lib, ... }:
let
  inherit (builtins) readFile;
  ob = ''
    (leaf org-babel
      :init
      (leaf ob-typescript :ensure t)
      (leaf ob-deno :ensure t)
      :setq
      (org-plantuml-jar-path . "${pkgs.plantuml}/lib/plantuml.jar")
      :config
      (org-babel-do-load-languages
        'org-babel-load-languages
        '((emacs-lisp . t)
          (shell . t)
          (awk . t)
          (calc . t)
          (css . t)
          (gnuplot . t)
          (haskell . t)
          (java . t)
          (js . t)
          (lua . t)
          (ocaml . t)
          (org . t)
          (plantuml . t)
          (python . t)
          (ruby . t)
          (sass . t)
          (scala . nil)
          (sql . t)
          (sqlite . t)
          (table . t)
          ;; ob-typescript
          (typescript . t)
          ;; ob-deno
          (deno . t)))
      :custom
      (;; 実行の確認をしない
       (org-confirm-babel-evaluate . nil)
       (org-src-fontify-natively . t)
       ;; TAB の挙動
       (org-src-tab-acts-natively . t)
       ;; インデント
       (org-edit-src-content-indentation . t)
       ;; インデントを残す
       (org-src-preserve-indentation . t)))
  '';
  lsp = ''
    ;; lsp
    (leaf eglot
      :ensure t
      :bind
      (:eglot-mode-map
       ("C-c e f" . eglot-format)
       ("C-c e r" . eglot-rename))
      :hook
      ((typescript-mode-hook . eglot-ensure)
       (js-mode-hook . eglot-ensure))
      :config)
  '';
in {
  programs.doom-emacs = {
    enable = false;
    doomPrivateDir = ./doom.d;
    emacsPackage = pkgs.emacs;
  };

  programs.emacs = { enable = false; };

  home.packages = with pkgs; [ nodePackages.typescript-language-server ];

  home.file = {
    ".emacs.d/early-init.el".text = readFile ./emacs.d/early-init.el;
    ".emacs.d/init.el".text = readFile ./emacs.d/init.el + ''
      ${ob}
      ${lsp}
    '';
  };
}

