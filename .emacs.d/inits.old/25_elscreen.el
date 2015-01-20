(require 'elscreen)

(elscreen-start)
;; タブコントロールを左端に表示しない
(setq elscreen-tab-display-control nil)
;; タブを閉じる [X] を表示しない
(setq elscreen-tab-display-kill-screen nil)
;; タブの幅
(setq elscreen-display-tab 15)

;; タブが1つの時にタブ移動をすると自動でスクリーンを生成する
(defmacro elscreen-create-automatically (ad-do-it)
  `(if (not (elscreen-one-screen-p))
       ,ad-do-it
     (elscreen-create)
     (elscreen-notify-screen-modification 'force-immediately)
     (elscreen-message "New screen is automatically created")))
(defadvice elscreen-next (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))
(defadvice elscreen-previous (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))
(defadvice elscreen-toggle (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

;; 切り替えキー
(global-set-key (kbd "<C-tab>") 'elscreen-next)
(global-set-key (kbd "<C-S-tab>") 'elscreen-previous)
(global-set-key (kbd "<C-S-iso-lefttab>") 'elscreen-previous)

;; emacsclient からは別のタブで開く
(require 'elscreen-server nil t)

(defun helm-with-new-elscreen ()
  "新しい elscreen で helm"
  (interactive)
  (elscreen-create)
  (helm-my))
(define-key global-map (kbd "C-:") 'helm-with-new-elscreen)

(defun dired-with-new-elscreen ()
  "新しい elscreen で dired"
  (interactive)
  (let ((current-dir (expand-file-name ".")))
    (elscreen-create)
    (dired current-dir)))
(define-key global-map (kbd "C-x j") 'dired-with-new-elscreen)

(define-key global-map (kbd "C-z C-c") 'elscreen-clone)
(define-key global-map (kbd "C-z C-k") 'elscreen-kill-screen-and-buffers)
