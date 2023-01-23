(use-package php-mode
  :ensure t
  :mode ("\\.php\\’" . php-mode)
  :custom
  (phpstan-memory-limit "3G"))

(use-package phpunit
  :ensure t)
