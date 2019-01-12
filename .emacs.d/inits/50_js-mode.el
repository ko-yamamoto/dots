(use-package js2-mode
  :defer t
  :config
  (add-to-list 'auto-mode-alist (cons (rx ".js" eos) 'js2-mode))
  (setq-default js2-basic-offset 2))
