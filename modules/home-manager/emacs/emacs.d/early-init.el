;;; -*- lexical-binding: t -*-

;; properties
(setq-default tab-width 2)
;; ベル SE の無効化
(setq visible-bell t)
(setq enable-recursive-minibuffers t)
;; スクロールバー非表示
(scroll-bar-mode -1)
;; 行数表示
(column-number-mode t)
;; 対応するかっこ
(show-paren-mode t)
;; ミニマルなフレーム
(add-to-list 'default-frame-alist '(undecorated . t))
;; 日本語
(set-language-environment "Japanese")
;; フォント
(setq default-frame-alist
	(append
    (list
      '(font . "HackGen Console NF-18"))
    default-frame-alist))
