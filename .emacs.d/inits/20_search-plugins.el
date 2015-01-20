(use-package migemo
  :ensure t
  :config
  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (setq migemo-regex-dictionary nil)
  (load-library "migemo")
  (migemo-init)
  )


(use-package color-moccur
  :defer t
  :ensure t
  :bind (("M-o" . occur-by-moccur)
         ("C-M-o" . moccur-grep-find))
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

  (add-hook 'dired-mode-hook ;dired
            '(lambda ()
               (local-set-key (kbd "O") 'dired-do-moccur)))

  (require 'moccur-edit nil t)
  ;; moccur-edit-finish-editと同時にファイルを保存する
  (defadvice moccur-edit-change-file
      (after save-after-moccur-edit-buffer activate)
    (save-buffer))

  )


(use-package ace-jump-mode
  :ensure t
  :defer t
  :bind (("C-c SPC" . ace-jump-mode))
  :config
  ;; C-u プレフィックスで起動する順番変更
  (setq ace-jump-mode-submode-list
        '(ace-jump-line-mode              ;; the third one always map to ：C-u C-u C-c SPC
          ace-jump-char-mode              ;; the second one always map to: C-u C-c SPC
          ace-jump-word-mode              ;; the first one always map to : C-c SPC
          )))