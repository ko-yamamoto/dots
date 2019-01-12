(use-package elscreen
  :bind (("<C-tab>" . elscreen-next)
         ("<C-S-tab>" . elscreen-previous)
         ("<C-S-iso-lefttab>" . elscreen-previous)
         ("C-:" . helm-with-new-elscreen)
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
  (setq elscreen-display-tab 22)

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

  (defun helm-with-new-elscreen ()
    "新しい elscreen で helm"
    (interactive)
    (elscreen-create)
    (helm-my))

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
  (setq elscreen-display-tab nil)

  ;; elscreenのタブをフレームタイトルに入れる - Qiita
  ;; https://qiita.com/kaz-yos/items/9dffd94694adf59449b7
  ;;;  Use frame-title for tabs
  ;; How to display the list of screens on the frame-title of my Emacs?
  ;; This is broken. get-alist should be changed to alist-get
  ;; https://www.emacswiki.org/emacs/EmacsLispScreen#toc8
  ;;
  (defvar *elscreen-tab-truncate-length*
    35 "Number of characters to truncate tab names in frame title")

  (defun elscreen-tabs-as-string ()
    "Return a string representation of elscreen tab names

Set name truncation length in ELSCREEN-TRUNCATE-LENGTH"
    (let* ((screen-list (sort (elscreen-get-screen-list) '<))
           (screen-to-name-alist (elscreen-get-screen-to-name-alist)))
      ;; mapconcat: mapping and then concate name elements together with separator
      (mapconcat
       (lambda (screen)
         (format (if (string-equal "+" (elscreen-status-label screen))
                     ;; Current screen format
                     "< %d > %s"
                   ;; Others
                   "   %d    %s")
                 ;; screen number: replaces %d (integer)
                 screen
                 ;; screen name: replaces %s (string)
                 (elscreen-truncate-screen-name
                  ;; Return the value associated with KEY in ALIST
                  (alist-get screen screen-to-name-alist)
                  *elscreen-tab-truncate-length* t)))
       ;; Screen numbers (keys for alist)
       screen-list
       ;; Separator
       "   |   ")))
  ;;
  (defvar *elscreen-tabs-as-string*
    "" "Variable to hold curent elscreen tab names as a string")
  ;;
  (defun update-elscreen-tabs-as-string ()
    "Update *elscreen-tabs-as-string* variable"
    (interactive)
    (setq *elscreen-tabs-as-string* (elscreen-tabs-as-string)))
  ;;
  ;; Update *elscreen-tabs-as-string* whenever elscreen status updates
  (add-hook 'elscreen-screen-update-hook 'update-elscreen-tabs-as-string)
  ;;
  ;; Set frame title format as combination of current elscreen tabs and buffer/path
  (setq frame-title-format '(:eval (concat *elscreen-tabs-as-string*)))


  )

(use-package elscreen-persist
  :straight (elscreen-persist-only :type git :host github :repo "robario/elscreen-persist" :files ("elscreen-persist.el"))
  :config
  (elscreen-persist-mode 1)
  )

(use-package shackle
  :config
  (setq shackle-rules
        '((compilation-mode :align below :ratio 0.2)
          ("*Help*" :align right :select t :ratio 0.4)
          ("*Backtrace*" :align right :select t :ratio 0.4)
          ("*Completions*" :align below :ratio 0.3)
          ("*Compile-Log*" :align below :ratio 0.3)
          ("\*helm" :regexp t :ratio 0.375 :align below)
          ("\*magit" :regexp t :align right :ratio 0.4)
          ("*Moccur*" :align right :ratio 0.4 :same t)
          ("*ag" :regexp t :align right :ratio 0.4 :same t)
          ;; 上部に表示
          ;; ("foo" :align above)
          ;; 別フレームで表示
          ;; ("bar" :frame t)
          ;; 同じウィンドウで表示
          ;; ("baz" :same t)
          ;; ポップアップで表示
          ;; ("hoge" :popup t)
          ;; 選択する
          ;; ("abc" :select t)
          ))

  (shackle-mode 1)
  (setq shackle-lighter "")

  ;; C-zで直前のウィンドウ構成に戻す
  ;; (winner-mode 1)
  ;; (global-set-key (kbd "C-g") 'winner-undo)
  )

(use-package scratch-log
  :config
  (setq sl-scratch-log-file "~/.emacs.d/.scratch-log")
  (setq sl-prev-scratch-string-file "~/.emacs.d/.scratch-log-prev")

  ;; nil なら emacs 起動時に，最後に終了したときの スクラッチバッファの内容を復元しない。初期値は t です。
  (setq sl-restore-scratch-p t)
  ;; nil なら スクラッチバッファを削除できるままにする。初期値は t です。
  (setq sl-prohibit-kill-scratch-buffer-p t)
  )

(use-package buffer-move
  :bind (("C-q L" . buf-move-right)
         ("C-q H" . buf-move-left)
         ("C-q J" . buf-move-down)
         ("C-q K" . buf-move-up)))
