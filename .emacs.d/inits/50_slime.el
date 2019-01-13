(use-package slime
  :disabled
  :defer t
  :config
  ;; Clozure CLをデフォルトのCommon Lisp処理系に設定
  (when is_win
    (setq inferior-lisp-program "ccl.bat"))
  (when is_mac
    (setq inferior-lisp-program "ccl"))
  (when is_linux
    (setq inferior-lisp-program "ccl"))

  (require 'slime-autoloads)
  (slime-setup '(slime-repl))

  ;; (require 'ac-slime)
  ;; (add-hook 'slime-mode-hook 'set-up-slime-ac)
  ;; (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
  ;; (eval-after-load "auto-complete"
  ;;   '(add-to-list 'ac-modes 'slime-repl-mode))
  )
