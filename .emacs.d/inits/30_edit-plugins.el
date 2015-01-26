(use-package fuzzy :ensure t)

(use-package auto-complete
  ;; :disabled t
  :ensure t
  :config
  (require 'auto-complete-config)
  (ac-config-default)
  (global-auto-complete-mode t)

  (add-to-list 'ac-sources 'ac-source-filename)
  (add-to-list 'ac-sources 'ac-source-files-in-current-dir)
  (add-to-list 'ac-sources 'ac-source-words-in-all-buffer)

  (setq ac-use-menu-map t) ;; 補完メニュー表示時に特別なキーマップを有効にするか
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict") ;; 辞書ファイルの位置
  (define-key ac-mode-map (kbd "M-c") 'auto-complete) ;; 補完の開始キー
  ;; (define-key ac-menu-map "q" 'ac-stop) ;; 補完を止めるキー
  (setq ac-auto-show-menu 0.1) ;; 補完メニュー表示までのディレイ
  (setq ac-menu-height 15) ;;補完メニューの行数
  (setq ac-ignore-case 'smart) ;; 大文字・小文字の区別方法
  (setq ac-dwim t) ;; 補完選択時にTABをRETの挙動にしない
  ;; (setq popup-use-optimized-column-computation nil) ;; 表示崩れ防止
  (setq ac-auto-start 2) ;; n文字以上の単語の時に補完を開始
  (setq ac-use-fuzzy t) ;; あいまい有効
  (setq ac-use-comphist t)  ;; 補完推測機能有効
  (ac-set-trigger-key "TAB")

  ;; 追加モード
  (add-to-list 'ac-modes 'org-mode)
  (add-to-list 'ac-modes 'gfm-mode)
  )

(use-package anzu
  :ensure t
  :defer t
  :bind (("M-%" . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp))
  :init
  (global-anzu-mode)
  )

(use-package expand-region
  :ensure t
  :defer t
  :bind (("C-@" . er/expand-region)
         ("C-M-@" . er/contract-region) ;; リージョンを狭める
         ("C-=" . er/expand-region)
         ("C-M-=" . er/contract-region) ;; リージョンを狭める
         ("C-o" . er/expand-region)))

(use-package multiple-cursors
  :ensure t
  :defer t)

(use-package point-undo
  :ensure t
  :defer t
  :bind (("<f7>" . point-undo)
         ("S-<f7>" . point-redo)))

(use-package goto-chg
  :ensure t
  :defer t
  :bind (("<f8>" . goto-last-change)
         ("S-<f8>" . goto-last-change-reverse)))

(use-package undo-tree
  :ensure t
  :defer t
  :bind (("C-/" . undo-tree-undo)
         ("M-/" . undo-tree-redo))
  :config
  (global-undo-tree-mode)
  ;; デフォルトで時間を表示
  (setq undo-tree-visualizer-timestamps t)
  )

(use-package wrap-region
  :ensure t
  :config
  (wrap-region-global-mode t)
  )

(use-package smartrep
  :ensure t
  :config
  (smartrep-define-key
      global-map "C-q" '(("c" . 'elscreen-create)
                         ("n" . 'elscreen-next)
                         ("p" . 'elscreen-previous)
                         ("a" . 'elscreen-toggle)
                         ("k" . 'elscreen-kill)
                         ("x" . 'elscreen-kill)
                         ))
  ;; ("a" . (lambda () (beginning-of-buffer-other-window 0)))
  ;; ("e" . (lambda () (end-of-buffer-other-window 0)))))

  ;; multiple-cursors
  (global-unset-key (kbd "C-c m"))
  (smartrep-define-key global-map (kbd "C-c m")
    '(("n"        . 'mc/mark-next-like-this)
      ("p"        . 'mc/mark-previous-like-this)
      ("m"        . 'mc/mark-more-like-this-extended)
      ("u"        . 'mc/unmark-next-like-this)
      ("U"        . 'mc/unmark-previous-like-this)
      ("s"        . 'mc/skip-to-next-like-this)
      ("S"        . 'mc/skip-to-previous-like-this)
      ("*"        . 'mc/mark-all-like-this)
      ("d"        . 'mc/mark-all-like-this-dwim)
      ("i"        . 'mc/insert-numbers)
      ("o"        . 'mc/sort-regions)
      ("O"        . 'mc/reverse-regions)))


  (smartrep-define-key global-map (kbd "C-q")
    '(("["        . 'historyf-back)
      ("]"        . 'historyf-forward)))

  (smartrep-define-key global-map (kbd "C-q")
    '(("l"        . 'windmove-right)
      ("h"        . 'windmove-left)
      ("j"        . 'windmove-down)
      ("k"        . 'windmove-up)))
  )
