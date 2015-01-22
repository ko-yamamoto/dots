(use-package tramp
  :defer t
  :config
  ;; (setq-default tramp-default-method "sshx")
  ;; (setq-default tramp-default-method "scpc")

  ;; 再接続用ファイルは作らない -> Solaris でエラーが出るため
  ;; (setq-default tramp-persistency-file-name nil)


  ;; Tramp バッファにユーザ名とホスト名を追加する
  (defun tramp-my-append-buffer-name-hint ()
    "Append a hint (user, hostname) to a buffer name if visiting
file is a remote file (include directory)."
    (let ((name (or list-buffers-directory (buffer-file-name))))
      (when (and name (tramp-tramp-file-p name))
        (let* ((tramp-vec (tramp-dissect-file-name name))
               (method (tramp-file-name-method tramp-vec))
               (host (tramp-file-name-real-host tramp-vec))
               (user (or (tramp-file-name-real-user tramp-vec)
                         (nth 2 (assoc method tramp-default-user-alist))
                         tramp-default-user
                         user-real-login-name)))
          (rename-buffer (concat (buffer-name) " <" user "@" host ">") t)))))
  (add-to-list 'find-file-hook 'tramp-my-append-buffer-name-hint)
  (add-to-list 'dired-mode-hook 'tramp-my-append-buffer-name-hint)


  ;; sudo でログインするための設定
  (add-to-list 'tramp-default-proxies-alist
               '(nil "\\`root\\'" "/ssh:%h:"))
  (add-to-list 'tramp-default-proxies-alist
               '("localhost" nil nil))
  (add-to-list 'tramp-default-proxies-alist
               '((regexp-quote (system-name)) nil nil))

  (when is_winnt
    ;; NTEmacs @ ウィキ - tramp を tramp-method “scp” で使うための設定 - http://www49.atwiki.jp/ntemacs/pages/17.html
    (setq tramp-default-method "scpx")
    ;; (setq explicit-shell-file-name "bash")
    ;; (setq tramp-encoding-shell "bash")

    ;; ドライブレターの後の「：」が tramp-method の後の「：」と混同されるのを対策する
    (defadvice tramp-do-copy-or-rename-file-out-of-band (around ad-tramp-do-copy-or-rename-file-out-of-band activate)
      (let ((default-directory "/"))
        (unless (tramp-tramp-file-p (ad-get-arg 1))
          (ad-set-arg 1 (substring (shell-command-to-string
                                    (concat "cygpath -u " (shell-quote-argument (ad-get-arg 1))))
                                   0 -1)))
        (unless (tramp-tramp-file-p (ad-get-arg 2))
          (ad-set-arg 2 (substring (shell-command-to-string
                                    (concat "cygpath -u " (shell-quote-argument (ad-get-arg 2))))
                                   0 -1))))
      ad-do-it
      (sit-for 0.1)) ; delay（NTEmacs64 では必要）

    ;; 通信するデータを圧縮する（オプション）
    (setcdr (assq 'tramp-login-args (assoc "scp" tramp-methods))
            (list (cons '("-C") (cadr (assq 'tramp-login-args (assoc "scp" tramp-methods))))))
    (setcdr (assq 'tramp-copy-args (assoc "scp" tramp-methods))
            (list (cons '("-C") (cadr (assq 'tramp-copy-args (assoc "scp" tramp-methods))))))

    ;; リモートサーバで shell を開いた時に日本語が文字化けしないよう、LC_ALL の設定を無効にする
    ;; http://www.gnu.org/software/emacs/manual/html_node/tramp/Remote-processes.html#Running%20a%20debugger%20on%20a%20remote%20host
    (let ((process-environment tramp-remote-process-environment))
      (setenv "LC_ALL" nil)
      (setq tramp-remote-process-environment process-environment))
    )

  (defun my-tramp-closing ()
    "tramp のバッファを全て閉じ、全接続を終了する"
    (interactive)
    (tramp-cleanup-all-buffers)
    (tramp-cleanup-all-connections))

  ;; vc が無視するファイルに tramp 接続したファイルを追加
  (setq vc-ignore-dir-regexp
        (format "\\(%s\\)\\|\\(%s\\)"
                vc-ignore-dir-regexp
                tramp-file-name-regexp))
  )
