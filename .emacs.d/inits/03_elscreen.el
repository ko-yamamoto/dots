(use-package elscreen
  :commands ()
  :bind (("<C-tab>" . elscreen-next)
         ("<C-S-tab>" . elscreen-previous)
         ("<C-S-iso-lefttab>" . elscreen-previous)
         ;; ("C-x j" . dired-with-new-elscreen)
         ("C-q c" . elscreen-create)
         ("C-q C-c" . elscreen-clone)
         ("C-q x" . elscreen-kill)
         ("C-q X" . elscreen-kill-screen-and-buffers)
         ("C-q C-x" . elscreen-kill-screen-and-buffers)
         ("C-q t" . elscreen-toggle-display-tab)
         ("C-q T" . elscreen-toggle-display-tab))
  :init
  (setq elscreen-prefix-key "\C-q")
  (elscreen-start)
  :config

  ;; タブコントロールを左端に表示しない
  (setq elscreen-tab-display-control nil)
  ;; タブを閉じる [X] を表示しない
  (setq elscreen-tab-display-kill-screen nil)
  ;; タブの幅
  (setq elscreen-display-tab 30)

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

  ;; emacsclient からは別のタブで開く
  (require 'elscreen-server nil t)

  (defun dired-with-new-elscreen ()
    "新しい elscreen で dired"
    (interactive)
    (let ((current-dir (expand-file-name ".")))
      (elscreen-create)
      (dired current-dir)))

  ;; (defun temp-display-tab ()
  ;;   ;; 一定時間タブを表示
  ;;   (setq elscreen-display-tab t)
  ;;   (run-at-time "1.5 sec" nil
  ;;                #'(lambda ()
  ;;                    (setq elscreen-display-tab nil)
  ;;                    (elscreen-notify-screen-modification 'force))))
  ;; (advice-add 'elscreen-next :after #'temp-display-tab)
  ;; (advice-add 'elscreen-previous :after #'temp-display-tab)

  (use-package elscreen-persist
    :straight (elscreen-persist-only :type git :host github :repo "robario/elscreen-persist" :files ("elscreen-persist.el"))
    :config
    (elscreen-persist-mode 1)
    )

  )
