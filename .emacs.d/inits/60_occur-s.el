;;====================
;; color-moccur
;;====================
(use-package color-moccur
  :config

  ;; スペース区切りの複数語での検索を行う場合は t
  (setq moccur-split-word t)
  ;; q で終了したらバッファも閉じる
  (setq moccur-kill-moccur-buffer t)
  ;; migemoがrequireできる環境ならmigemoを使う
  (when (require 'migemo nil t) ;第三引数がnon-nilだとloadできなかった場合にエラーではなくnilを返す
    (setq moccur-use-migemo t))
  ;; t であればカーソル付近の単語をデフォルトの検索語とする
  (setq moccur-grep-default-word-near-point nil)

  ;; ディレクトリ検索のとき除外するファイル
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$")
  (add-to-list 'dmoccur-exclusion-mask "\\.git\\/\*")

  (global-set-key (kbd "M-o") 'occur-by-moccur)
  (global-set-key (kbd "C-M-o") 'moccur-grep-find)
  (add-hook 'dired-mode-hook ;dired
            '(lambda ()
               (local-set-key (kbd "O") 'dired-do-moccur)))

  ;;====================
  ;; moccur-edit
  ;;====================
  (require 'moccur-edit nil t)

  ;; moccur-edit-finish-editと同時にファイルを保存する
  (defadvice moccur-edit-change-file
    (after save-after-moccur-edit-buffer activate)
    (save-buffer))

  )
