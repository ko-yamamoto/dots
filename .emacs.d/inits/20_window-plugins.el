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
