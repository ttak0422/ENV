;;; -*- lexical-binding: t -*-

(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

;; package
(leaf leaf-keywords
  :ensure t
  :init
  (leaf el-get :ensure t)
  :config
  (leaf-keywords-init))

;; completion
(leaf vertico
  :ensure t
  :init
  (vertico-mode))
(leaf savehist
  :init
  (savehist-mode))
(leaf company
  :ensure t
  :blackout t
  :leaf-defer nil
  :bind (
    (company-active-map
      ("M-n" . nil)
      ("M-p" . nil)
      ("C-s" . company-filter-candidates)
      ("C-n" . company-select-next)
      ("C-p" . company-select-previous)
      ("<tab>" . company-complete-selection))
    (company-search-map
      ("C-n" . company-select-next)
      ("C-p" . company-select-previous)))
  :custom (
    (company-minimum-prefix-length . 1)
    (company-transformers . '(company-sort-by-occurrence)))
  :global-minor-mode global-company-mode)

;; evil
(leaf evil
  :ensure t
  :setq
  (evil-want-C-u-scroll . t)
  :config
  (evil-mode 1))

;; input
(leaf ddskk
  :ensure t
  :bind (("C-x C-j" . skk-mode))
  :setq
  (skk-byte-compile-init-file . t)
  (skk-preload . t)
  (skk-isearch-mode-enable . 'always)
  (default-input-method . "japanese-skk")
  (skk-kuten-touten-alist '(
    (jp . ("．" . "，"))
    (en . ("." . ","))
  ))
  (skk-server-host . "127.0.0.1")
  (skk-server-portnum . 1178)
  (skk-auto-insert-paren . t))
;; 参考 (https://github.com/doomemacs/doomemacs/blob/c44bc81a05f3758ceaa28921dd9c830b9c571e61/modules/input/japanese/config.el#L25-L34)
(leaf pangu-spacing
  :ensure t
  :hook (text-mode . pangu-spacing-mode)
  :init
  (setq pangu-spacing-chinese-before-english-regexp
    "\\(?1:\\cj\\)\\(?2:[0-9A-Za-z]\\)"
    pangu-spacing-chinese-after-english-regexp
    "\\(?1:[0-9A-Za-z]\\)\\(?2:\\cj\\)"
    pangu-spacing-real-insert-separtor t))
(global-pangu-spacing-mode 1)

;; typescript
(leaf typescript-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode)))

;; org
(leaf org
  :ensure t
  :setq
  (org-startup-folded . nil)
  (org-directory . "~/org")
  (org-default-notes-file . "noname.org")
  (org-hide-emphasis-markers . t)
  :bind
  (("C-c l" . org-store-link)
   ("C-c c" . org-capture)
   ("C-c a" . org-agenda)))
(leaf org-fragtog
  :ensure t
  :hook (org-mode-hook . org-fragtog-mode))
(leaf org-latex
  :hook (org-mode-hook . (lambda () (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0)))))
(leaf org-bullets
  :ensure t
  :hook (org-mode-hook . (lambda () (org-bullets-mode 1))))

;; theme
(leaf nano-theme
  :ensure t
  :require t
  :config
  (nano-light)
  (nano-mode)
  :setq
  ;;(nano-fonts-use . t)
    )

(leaf nano-modeline
  :ensure t
  :require t
  :config
  (nano-modeline-mode)
  (require 'nano-theme)
  :setq
  (nano-modeline-prefix . 'status)
  (nano-modeline-prefix-padding . 1))
