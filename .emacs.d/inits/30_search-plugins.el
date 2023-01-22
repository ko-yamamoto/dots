(use-package migemo
  :config
  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init)
  )


(use-package color-moccur
  :defer t
  ;; → hydra
  ;; :bind (("C-q o o" . occur-by-moccur)
  ;;        ("C-q o m" . moccur-grep-find))
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
    :config
    ;; moccur-edit-finish-editと同時にファイルを保存する
    (defadvice moccur-edit-change-file
        (after save-after-moccur-edit-buffer activate)
      (save-buffer)))

  )

(use-package ag
  :defer t
  :init
  (bind-key "C-q a" nil) ;; remove elscreen-toggle key
  ;; → hydra
  ;; :bind (("C-q a g" . ag)
  ;;        ("C-q a G" . ag-regexp)
  ;;        ("C-q a f" . ag-dired)
  ;;        ("C-q a F" . ag-dired-regexp))
  :config
  (use-package wgrep-ag)
  (setq ag-arguments '("--line-number" "--smart-case" "--nogroup" "--column" "--stats" "--vimgrep" "--"))
  (setq ag-highlight-search t)  ; 検索結果の中の検索語をハイライトする
  (autoload 'wgrep-ag-setup "wgrep-ag")
  (add-hook 'ag-mode-hook 'wgrep-ag-setup)
  (setq wgrep-auto-save-buffer t) ;; 編集を保存したら全てのバッファを保存する
  (setq wgrep-enable-key "r")
  )

(use-package imenu
  ;; :bind (("M-i" . counsel-imenu))
  :config
  (setq imenu-auto-rescan t)
  ;; imenu で表示する階層の深さ
  (setq org-imenu-depth 3))


(use-package isearch-dabbrev
  :config
  (bind-keys :map isearch-mode-map
             ("<tab>" . isearch-dabbrev-expand)))



(use-package highlight-symbol
  :config
  ;; 自動ハイライトされるようになるまでの時間
  (setq highlight-symbol-idle-delay 0.3)
  ;; 自動ハイライトをしたいならば
  (add-hook 'markdown-mode-hook 'highlight-symbol-mode)
  (add-hook 'find-file-hook 'highlight-symbol-mode)
  ;; ソースコードにおいてM-p/M-nでシンボル間を移動
  (add-hook 'markdown-mode-hook 'highlight-symbol-nav-mode)
  (add-hook 'find-file-hook 'highlight-symbol-nav-mode)
  ;; シンボル置換
  (global-set-key (kbd "M-s M-r") 'highlight-symbol-query-replace))


(use-package dumb-jump
  :bind (("M-." . dumb-jump-go))
  :config
  (setq dumb-jump-mode t)
  (setq dumb-jump-selector 'ivy) ;; 候補選択をivyに任せます
  (setq dumb-jump-use-visible-window nil))
