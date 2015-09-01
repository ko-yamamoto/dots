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
  :bind (("C-c o o" . occur-by-moccur)
         ("C-c o m" . moccur-grep-find))
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

  (use-package moccur-edit
    :ensure t
    :config
    ;; moccur-edit-finish-editと同時にファイルを保存する
    (defadvice moccur-edit-change-file
        (after save-after-moccur-edit-buffer activate)
      (save-buffer)))

  )


(use-package imenu
  :config
  (setq imenu-auto-rescan t)
  ;; imenu で表示する階層の深さ
  (setq org-imenu-depth 3))

(use-package imenu-anywhere
  ;; imenu を同一メジャーモードのマルチバッファ化
  :ensure t
  :defer t
  :bind (("M-i" . ido-imenu-anywhere)))
  ;; :bind (("M-i" . helm-imenu-anywhere)))


(use-package isearch-dabbrev
  :ensure t
  :config
  (bind-keys :map isearch-mode-map
             ("<tab>" . isearch-dabbrev-expand)))
