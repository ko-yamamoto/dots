(require 'expand-region)

(global-set-key (kbd "C-@") 'er/expand-region)
(global-set-key (kbd "C-M-@") 'er/contract-region) ;; リージョンを狭める
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-M-=") 'er/contract-region) ;; リージョンを狭める
(global-set-key (kbd "C-o") 'er/expand-region)
