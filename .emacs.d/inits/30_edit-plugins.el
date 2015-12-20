(use-package fuzzy :ensure t)

(use-package company
  :ensure t
  ;; :bind (("M-c" . company-complete-common2))

  :config
  (global-company-mode) ; 全バッファで有効にする
  (setq company-idle-delay 0) ; デフォルトは0.5
  (setq company-minimum-prefix-length 1) ; デフォルトは4
  (setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
  (setq company-dabbrev-downcase nil) ; 候補をすべて小文字で扱うのを停止

  ;; 補完の使用頻度でソート
  (use-package company-statistics
    :ensure t
    :config
    (company-statistics-mode)
    (setq company-transformers '(company-sort-by-statistics company-sort-by-backend-importance)))

  (use-package company-try-hard
    :ensure t
    :config
    (global-set-key (kbd "M-c") #'company-try-hard)
    (define-key company-active-map (kbd "M-c") #'company-try-hard))

  (bind-keys :map company-active-map
             ("M-n" . nil)
             ("M-p" . nil)
             ("C-n" . company-select-next)
             ("C-p" . company-select-previous)
             ("C-h" . nil)
             ("C-w" . kill-region-or-backward-word)
             ("<tab>" . company-complete-common-or-cycle) ; 1つしか候補がなかったらtabで補完/複数候補があればtabで次の候補へ
             ("<iso-lefttab>" . company-complete-common-or-cycle)
             ("<S-tab>" . company-select-previous)
             ("<S-iso-lefttab>" . company-select-previous)
             )

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
         ("C-o" . er/expand-region)
         ("C-M-o" . er/contract-region)))

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
  (setq smartrep-mode-line-active-bg "#f2777a")

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

  (smartrep-define-key global-map (kbd "C-q")
    '(("L"        . 'buf-move-right)
      ("H"        . 'buf-move-left)
      ("J"        . 'buf-move-down)
      ("K"        . 'buf-move-up)))

  (smartrep-define-key global-map (kbd "C-x")
    '(("n"        . 'next-buffer)
      ("p"        . 'previous-buffer)))

  )

(use-package smart-newline
  :ensure t
  :bind (("C-m" . smart-newline))
  :config
  (add-hook 'emacs-lisp-mode-hook 'smart-newline-mode)
  (add-hook 'org-mode-hook 'smart-newline-mode)
  (add-hook 'gfm-mode-hook 'smart-newline-mode)
  (add-hook 'markdown-mode-hook 'smart-newline-mode)

  (defadvice smart-newline (around C-u activate)
    "C-u を押したら元の C-m の挙動をするように"
    (if (not current-prefix-arg)
        ad-do-it
      (let (current-prefix-arg)
        (let (smart-newline-mode)
          (call-interactively (key-binding (kbd "C-m"))))))))

(use-package zzz-to-char
  :ensure t
  :bind (("M-z" . zzz-up-to-char))
  :config
  (setq zzz-to-char-reach 480))


(use-package smart-mark
  :ensure t
  :config
  (smart-mark-mode))
