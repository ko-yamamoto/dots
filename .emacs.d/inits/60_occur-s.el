;;====================
;; color-moccur
;;====================
(require 'color-moccur)
(setq moccur-split-word t)

;; migemoがrequireできる環境ならmigemoを使う
;; (when (require 'migemo nil t) ;第三引数がnon-nilだとloadできなかった場合にエラーではなくnilを返す
;; (setq moccur-use-migemo t))

(global-set-key (kbd "M-o") 'occur-by-moccur)
(global-set-key (kbd "C-M-o") 'moccur-grep-find)
(add-hook 'dired-mode-hook ;dired
          '(lambda ()
             (local-set-key (kbd "O") 'dired-do-moccur)))


;;====================
;; moccur-edit
;;====================
(require 'moccur-edit)
(setq moccur-split-word t)

