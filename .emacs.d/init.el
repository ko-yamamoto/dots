;; (setq debug-on-error t)

;; load-path 追加
(setq load-path
      (append
       (list
        ;; (expand-file-name "~/.emacs.d/")
        (expand-file-name "~/.emacs.d/elisp/"))
       load-path))

;; 起動処理
;; init.el の分割
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits") ; 設定ファイルがあるディレクトリを指定
