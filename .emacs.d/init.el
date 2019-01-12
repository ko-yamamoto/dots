;; (setq debug-on-error t)
(setq gc-cons-threshold (* 128 1024 1024))

;; load-path 追加
(setq load-path
      (append
       (list
        ;; (expand-file-name "~/.emacs.d/")
        (expand-file-name "~/.emacs.d/elisp/"))
       load-path))

;; straight.el  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; use-packageをインストールする
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; 起動処理
;; init.el の分割
(use-package init-loader
  :config
  (init-loader-load "~/.emacs.d/inits") ; 設定ファイルがあるディレクトリを指定
  )
