(use-package js2-mode
  :disabled
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (setq-default js2-basic-offset 2))

(use-package json-mode :defer t)

