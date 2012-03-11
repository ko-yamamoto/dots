(add-to-list 'load-path "~/.emacs.d/elisp/tramp-2.2.4/lisp/")
(require 'tramp)

(setq-default tramp-default-method "sshx")

;; 再接続用ファイルは作らない -> Solaris でエラーが出るため
(setq-default tramp-persistency-file-name nil)
