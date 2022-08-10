(setq doom-font (font-spec :family "JetBrainsMonoExtraBold Nerd Font Mono" :size 16))

;; language
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; no titlebar
(add-to-list 'default-frame-alist '(undecorated . t))

;; nano
(nano-modeline-mode)

;; theme
(load-theme 'one-light t)
