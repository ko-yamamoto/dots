(use-package expand-region
  :ensure t
  :defer t
  :bind (("C-@" . er/expand-region)
         ("C-M-@" . er/contract-region) ;; リージョンを狭める
         ("C-=" . er/expand-region)
         ("C-M-=" . er/contract-region) ;; リージョンを狭める
         ("C-o" . er/expand-region)))
