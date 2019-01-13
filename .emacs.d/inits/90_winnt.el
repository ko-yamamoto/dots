(when is_winnt

  ;; emacs-24.4、emacs-24.5 では、4096バイトを超えるデータを一度にパイプ経由でプロセスに送り込むと、
  ;; レスポンスが帰ってこない状況となる。これを改善する。
  ;; （NTEmacsスレッド４ 714 の投稿を一部修正したもの。NTEmacsスレッド４ 734、737 の対策も兼ねるため、
  ;;   4096バイトを超えない入力の場合でも一律同じ処理を実行している。）
  (defconst w32-pipe-limit 4096)
  (defun ad-process-send-string (orig-fun &rest args)
    (if (not (eq (process-type (nth 0 args)) 'real))
        (apply orig-fun args)
      (let* ((process (or (nth 0 args)
                          (get-buffer-process (current-buffer))))
             (send-string (encode-coding-string (nth 1 args)
                                                (cdr (process-coding-system (get-process process)))))
             (send-string-length (length send-string)))
        (let ((inhibit-eol-conversion t)
              (from 0)
              to)
          (while (< from send-string-length)
            (setq to (min (+ from w32-pipe-limit) send-string-length))
            (setf (nth 1 args) (substring send-string from to))
            (apply orig-fun args)
            (setq from to))))))

  (advice-add 'process-send-string :around #'ad-process-send-string)

  ;; (setq default-input-method "W32-IME")
  ;; (setq-default w32-ime-mode-line-state-indicator "[--]")
  ;; (setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
  ;; (w32-ime-initialize)
  ;; 日本語入力時にカーソルの色を変える設定
  ;; (add-hook 'w32-ime-on-hook '(lambda () (set-cursor-color "#d33682")))
  ;; (add-hook 'w32-ime-off-hook '(lambda () (set-cursor-color "#4271ae")))

  ;; (setq cygwin-mount-cygwin-bin-directory "c:/cygwin/bin")
  (require 'cygwin-mount)
  (cygwin-mount-activate)
  (eval-after-load "gnutls" '(setq gnutls-trustfiles (mapcar 'expand-file-name gnutls-trustfiles)))

  )
