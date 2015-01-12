;; org-modeの初期化
;; (require 'org-install)
(require 'org)

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
(define-key global-map (kbd "C-c o o") 'open-my-org-directory)

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
(global-set-key (kbd "C-c o c") 'org-capture)



(defun my/view-as-orgtbl ()
  (interactive)
  (orgtbl-mode)
  (mark-whole-buffer)
  (org-table-convert-region (region-beginning) (region-end))
  (setq truncate-lines t))



;; key ;;;;;;;;;;;;;;;;;;;;;;;;

(define-key global-map (kbd "C-c o a") 'org-agenda)

;; remember-el
(define-key global-map (kbd "C-c o r") 'org-remember)

;; ファイルリンクの保存
(define-key global-map (kbd "C-c o l") 'org-store-link)

;; タブ移動は譲らない
(define-key org-mode-map [(control tab)] 'elscreen-next)
(define-key org-mode-map [(control shift tab)] 'elscreen-previous)

;; 見出しを移動
(define-key org-mode-map [(control up)] 'outline-previous-visible-heading)
(define-key org-mode-map [(control down)] 'outline-next-visible-heading)
(define-key org-mode-map [(control shift up)] 'outline-backward-same-level)
(define-key org-mode-map [(control shift down)] 'outline-forward-same-level)
(define-key org-mode-map (kbd "C-a") 'my-toggle-beginning-of-line-and-sentence)
