(use-package ediff
  :straight nil
  :config
  ;; ediffの分割は縦にウィンドウを並べる
  (setq ediff-split-window-function 'split-window-horizontally)
  (setq ediff-merge-split-window-function 'split-window-horizontally)

  ;; ediff開始前にelscreenのタブを非表示
  (add-hook 'ediff-mode-hook
            (lambda ()
              (setq elscreen-display-tab nil)
              (elscreen-notify-screen-modification 'force-immediately)
              ))
  ;; ediff終了後にelscreenのタブを表示
  (add-hook 'ediff-quit-hook
            (lambda ()
              (setq elscreen-display-tab 30)
              (elscreen-notify-screen-modification 'force-immediately)))

  )

(use-package fuzzy)


(use-package company
  ;; :bind (("M-c" . company-complete-common2))
  :config
  (global-company-mode) ; 全バッファで有効にする
  (setq company-idle-delay 0) ; デフォルトは0.5
  (setq company-minimum-prefix-length 1) ; デフォルトは4
  (setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
  (setq company-dabbrev-downcase nil) ; 候補をすべて小文字で扱うのを停止

  ;; 補完の使用頻度でソート
  (use-package company-statistics
    :config
    (company-statistics-mode)
    (setq company-transformers '(company-sort-by-statistics company-sort-by-backend-importance)))

  (use-package company-try-hard
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

  ;; show icons in company
  (use-package company-box
    :hook (company-mode . company-box-mode))

  (use-package company-quickhelp
    :config
    (company-quickhelp-mode))

  )

(use-package anzu
  :defer t
  :bind (("M-%" . anzu-query-replace))
  :init
  (global-anzu-mode))

;; (use-package visual-regexp
;;   :defer t
;;   ;; :init
;;   ;; (use-package visual-regexp-steroids)
;;   :bind (("C-M-%" . vr/query-replace)))

(use-package expand-region
  :defer t
  :bind (("C-=" . er/expand-region)
         ("C-M-=" . er/contract-region)))

(use-package multiple-cursors
  :bind
  (("C-M-<down>" . mc/mark-next-like-this)
   ("C-M-<up>" . mc/mark-previous-like-this)
   ("C-c C->" . mc/mark-all-like-this)
   )
  :config
  (setq mc/insert-numbers-default 1)
  (setq mc/cmds-to-run-for-all
        '(
          markdown-outdent-or-delete
          my-forward-word
          my-toggle-beginning-of-line-and-sentence
          ))
  (setq mc/cmds-to-run-once
        '(
          elscreen-next
          hydra-multiple-cursors/mc/insert-numbers-and-exit
          hydra-multiple-cursors/mc/mark-all-like-this-and-exit
          hydra-multiple-cursors/mc/mark-next-like-this
          )))

(use-package point-undo
  :bind
  ("<f7>" . point-undo)
  ("M-<left>" . point-undo)
  ("S-<f7>" . point-redo)
  ("M-<right>" . point-redo))

(use-package goto-chg
  :defer t
  :bind (("<f8>" . goto-last-change)
         ("S-<f8>" . goto-last-change-reverse)))

(use-package undo-tree
  :defer t
  :bind (("C-/" . undo-tree-undo)
         ("M-/" . undo-tree-redo))
  :config
  (global-undo-tree-mode)
  ;; 履歴ファイルを作らない
  (setq undo-tree-auto-save-history nil)
  ;; デフォルトで時間を表示
  (setq undo-tree-visualizer-timestamps t)
  )

(use-package wrap-region
  :config
  (wrap-region-global-mode t)
  )

(use-package smart-newline
  :config
  (smart-newline-mode 1)
  ; (add-hook 'gfm-mode-hook ((smart-newline-mode nil)))

  (defadvice smart-newline (around C-u activate)
    "C-u を押したら元の C-m の挙動をするように"
    (if (not current-prefix-arg)
        ad-do-it
      (let (current-prefix-arg)
        (let (smart-newline-mode)
          (call-interactively (key-binding (kbd "C-m"))))))))

(use-package zzz-to-char
  :bind (("M-z" . zzz-up-to-char))
  :config
  (setq zzz-to-char-reach 480))


(use-package smart-mark
  :config
  (smart-mark-mode))

(use-package drag-stuff
  :bind (("M-<up>" . drag-stuff-up)
         ("M-<down>" . drag-stuff-down)))

(use-package volatile-highlights
  :diminish
  :hook
  (after-init . volatile-highlights-mode))


(use-package yasnippet
  :straight t
  :bind (nil
         :map yas-keymap
         ("<tab>" . nil)
         ("TAB" . nil)
         ("<backtab>" . nil)
         ("S-TAB" . nil)
         ("C-o" . yas-next-field-or-maybe-expand))
  :init
  (yas-global-mode +1))

