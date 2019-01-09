(use-package ensime
  :ensure t
  :config
  (setq ensime-startup-notification nil)
  (setq ensime-search-interface 'helm))

(use-package scala-mode
  :interpreter
  ("scala" . scala-mode)
  :config
  (setq scala-indent:use-javadoc-style t))
