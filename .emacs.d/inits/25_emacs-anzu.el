(require 'anzu)

(global-anzu-mode)

;; 置換も anzu で
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)
