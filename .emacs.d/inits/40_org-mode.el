;; org-modeの初期化
(use-package org
  :defer t
  :bind (("C-c o o" . open-my-org-directory)
         ("C-c o c" . org-capture)
         ("C-c g f" . magit-file-log)
         ("C-c o a" . org-agenda)
         )
  :config
  ;; org-default-notes-fileのディレクトリ
  (setq org-directory "~/memo/")
  ;; org-default-notes-fileのファイル名
  (setq org-default-notes-file "notes.org")

  ;; TODO状態
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))
  ;; DONEの時刻を記録
  (setq org-log-done 'time)

  ;; アジェンダ表示の対象ファイル
  (setq org-agenda-files (list org-directory))
  ;; アジェンダ表示で下線を用いる
  ;; (add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))
  ;; (setq hl-line-face 'underline)
  ;; 標準の祝日を利用しない
  (setq calendar-holidays nil)

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
          ("n" "日報" entry (file+datetree "~/memo/nippo.org")
           "**** %?%i
     - [
     - 00:00 - 00:00")

          ))

  (defun my/view-as-orgtbl ()
    (interactive)
    (orgtbl-mode)
    (mark-whole-buffer)
    (org-table-convert-region (region-beginning) (region-end))
    (setq truncate-lines t))

  (bind-keys :map org-mode-map
             ("<C-tab>" . elscreen-next)
             ("<C-S-iso-lefttab>" . elscreen-previous)
             ("<C-up>" . outline-previous-visible-heading)
             ("<C-down>" . outline-next-visible-heading)
             ("<C-S-up>" . outline-backward-same-level)
             ("<C-S-down>" . outline-forward-same-level)
             ("C-a" . my-toggle-beginning-of-line-and-sentence))

  )
