;; (setq debug-on-error t)
(setq gc-cons-threshold (* 128 1024 1024))

;; load-path 追加
(setq load-path
      (append
       (list
        ;; (expand-file-name "~/.emacs.d/")
        (expand-file-name "~/.emacs.d/elisp/"))
       load-path))

;; package の初期化 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)


;; use-package  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (require 'use-package nil t)
  (message "Use-package is unavailable!")
  (defmacro use-package (&rest _args)))


;; 起動処理
;; init.el の分割
(use-package init-loader
  :pin melpa
  :ensure t
  :config
  (init-loader-load "~/.emacs.d/inits") ; 設定ファイルがあるディレクトリを指定
  )
