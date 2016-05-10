(use-package org
  :defer t
  :bind (("C-c o c" . org-capture)
         ("C-c g f" . magit-file-log)
         ("C-c o a" . org-agenda))
  :config
  ;; org-default-notes-fileのディレクトリ
  (setq org-directory "~/memo/")
  ;; org-default-notes-fileのファイル名
  (setq org-default-notes-file "notes.org")

  ;; DONEの時刻を記録
  (setq org-log-done 'time)

  ;; アジェンダ表示の対象ファイル
  (setq org-agenda-files (list org-directory))
  ;; アジェンダ表示で下線を用いる
  ;; (add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))
  ;; (setq hl-line-face 'underline)
  ;; 標準の祝日を利用しない
  (setq calendar-holidays nil)

  ;; 改行を維持する
  (setq org-export-preserve-breaks t)

  ;; 項目ごとの番号は出力しない
  (setq org-export-with-section-numbers nil)

  ;; ブラウザで確認
  (defun org-render-browser (n)
    (interactive "p")
    (message (buffer-file-name))
    (browse-url-of-file (org-html-export-to-html)))

  ;; org-directory を開く
  (defun open-my-org-directory ()
    (interactive)
    (elscreen-create)
    (find-file org-directory))

  ;; org-capture
  (require 'org-capture)
  (setq org-capture-templates
        '(("t" "Todo ノード追加" entry (file+headline "~/memo/Todos.org" "Todos")
           "* TODO %?
  %i
  %a
  %T")
          ("l" "Todo リスト追加" item (file+headline "~/memo/Todos.org" "TodoList")
           "- [ ] %?%i
  %T")
          ("m" "Memo" entry (file+headline nil "Memos")
           "** %?
  %i
  %a
  %T")
          ("n" "日報" entry (file+datetree+prompt "~/memo/nippo.org")
           "**** 所感・連絡事項など\n**** 作業内容\n***** %?\n- 00:00 → 00:00")
          ))


  ;; TODO状態
  (setq org-todo-keywords
        '((sequence "TODO" "DOING" "BLOCKED" "REVIEW" "|" "DONE" "ARCHIVED")))

  (setq org-todo-keyword-faces
        '(("TODO" . "#aaaaaa") ;; gray
          ("DOING" . "#ffcc66") ;; yellow
          ("BLOCKED" . "#f2777a") ;; red
          ("REVIEW" . "#f99157") ;; orange
          ("DONE" . "#6699cc") ;;blue
          ("ARCHIVED" .  "#99cc99"))) ;; green

  ;; DONE の時刻を記録
  (setq org-log-done 'time)

  (defun my/view-as-orgtbl ()
    (interactive)
    (orgtbl-mode)
    (mark-whole-buffer)
    (org-table-convert-region (region-beginning) (region-end))
    (setq truncate-lines t))

  ;; ソースハイライトを有効化
  (setq org-src-fontify-natively t)

  (use-package ox-gfm :ensure t)

  (bind-keys :map org-mode-map
             ("<C-tab>" . elscreen-next)
             ("<C-S-iso-lefttab>" . elscreen-previous)
             ("<C-up>" . outline-previous-visible-heading)
             ("<C-down>" . outline-next-visible-heading)
             ("<C-S-up>" . outline-backward-same-level)
             ("<C-S-down>" . outline-forward-same-level)
             ("C-a" . my-toggle-beginning-of-line-and-sentence)
             ("C-c SPC" . ace-jump-mode) ; 上書き
             ("C-m" . org-return-indent)
             ("C-c c" . org-render-browser)
             ("C-c ." . org-time-stamp-inactive))
  )
