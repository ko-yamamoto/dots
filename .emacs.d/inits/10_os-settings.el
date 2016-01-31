;;====================
;; For Mac
;;====================

(when is_mac

  ;; exec-pathとPATHに設定したいパスのリストを設定
  (dolist (dir (list
                "/usr/local/bin"
                "/usr/local/scala/bin"
                "~/bin"
                "/sbin"
                "/usr/sbin"
                "/bin"
                "/usr/bin"
                "/usr/local/ccl"
                "/usr/local/go/bin"
                "~/go/bin"
                (expand-file-name "~/bin")
                (expand-file-name "~/.emacs.d/bin")
                ))
    ;; PATH と exec-path に同じ物を追加
    (when (and (file-exists-p dir) (not (member dir exec-path)))
      (setenv "PATH" (concat dir ":" (getenv "PATH")))
      (setq exec-path (append (list dir) exec-path))))




  ;; Command-Key and Option-Key
  ;; コマンドキーをMetaに、Optionキーをsuperに
  (setq ns-command-modifier (quote meta))
  (setq ns-alternate-modifier (quote super))


  ;; CmdキーをSuperに、OptionキーをMetaに
  ;; (setq mac-option-modifier 'meta)
  ;; (setq mac-command-modifier 'super)


  ;; (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
  ;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


  ;; \の代わりにバックスラッシュを入力する
  (define-key global-map [165] [92])

  )


(when is_winnt

  ;; process-connection-type が nil で start-process がコールされるけれども、fakecygpty を経由して
  ;; 起動したいプログラムの名称を列挙する
  (defvar fakecygpty-program-list '("mozc_emacs_helper.sh"))

  ;; fakecygpty を経由するかを判断してプログラムを起動する
  (advice-add 'start-process
              :around (lambda (orig-fun &rest args)
                        (when (and (nth 2 args)
                                   (or process-connection-type
                                       (member (replace-regexp-in-string "\\.exe$" ""
                                                                         (file-name-nondirectory (nth 2 args)))
                                               fakecygpty-program-list)))
                          (push "fakecygpty" (nthcdr 2 args)))
                        (apply orig-fun args))
              '((depth . 100)))

  ;; fakecygpty を経由して起動したプロセスに対し、コントロールキーを直接送信する
  (cl-loop for (func ctrl-key) in '((interrupt-process "C-c")
                                    (quit-process      "C-\\")
                                    (stop-process      "C-z")
                                    (process-send-eof  "C-d"))
           do (eval `(advice-add ',func
                                 :around (lambda (orig-fun &rest args)
                                           (let ((process (or (nth 0 args)
                                                              (get-buffer-process (current-buffer)))))
                                             (if (string= (car (process-command process)) "fakecygpty")
                                                 (process-send-string (nth 0 args) (kbd ,ctrl-key))
                                               (apply orig-fun args)))))))

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


  (setq default-input-method "W32-IME")
  (setq-default w32-ime-mode-line-state-indicator "[--]")
  (setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
  (w32-ime-initialize)
  ;; 日本語入力時にカーソルの色を変える設定
  ;; (add-hook 'w32-ime-on-hook '(lambda () (set-cursor-color "#d33682")))
  ;; (add-hook 'w32-ime-off-hook '(lambda () (set-cursor-color "#4271ae")))
  )
