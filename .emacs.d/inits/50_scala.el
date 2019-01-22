;; Run `sbt ensimeConfig`
(use-package ensime
  :straight (:host github :repo "ensime/ensime-emacs"
             :branch "2.0")
  :config
  (setq ensime-startup-notification nil)
  (setq ensime-search-interface 'helm)
  (bind-keys :map ensime-mode-map
             ("M-n" . nil) ;; use highlight-symbol-nav
             ("M-p" . nil)) ;; use highlight-symbol-nav
  )

(use-package scala-mode
  :interpreter
  ("scala" . scala-mode)
  :config
  (setq scala-indent:use-javadoc-style t))
