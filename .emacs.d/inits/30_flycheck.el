(use-package flycheck
  :ensure t
  :config
  (use-package flycheck-pos-tip
    :ensure t
    :config
    (eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages))))

  (global-flycheck-mode)
  )
