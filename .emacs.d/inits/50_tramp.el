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

  (add-to-list 'backup-directory-alist
               (cons "." "~/.emacs.d/backup/"))
  (setq tramp-backup-directory-alist backup-directory-alist)
  (setq tramp-auto-save-directory "~/.emacs.d/backup/")

  (when is_winnt
    ;; NTEmacs @ ウィキ - tramp を tramp-method “scp” で使うための設定 - http://www49.atwiki.jp/ntemacs/pages/17.html
    (setq explicit-shell-file-name "bash")
    (setq tramp-default-method "scpx")
    (setq tramp-encoding-shell "f_sh")

    ;; リモートサーバで shell を開いた時に日本語が文字化けしないよう、LC_ALL と LC_CTYPE の設定を無効にする
    ;; http://www.gnu.org/software/emacs/manual/html_node/tramp/Remote-processes.html#Running%20a%20debugger%20on%20a%20remote%20host
    (let ((process-environment tramp-remote-process-environment))
      (setenv "LC_ALL" nil)
      (setenv "LC_CTYPE" nil)
      (setq tramp-remote-process-environment process-environment))

    ;; ドライブレターの後の「：」が tramp-method の後の「：」と混同されるのを対策する
    (advice-add 'tramp-do-copy-or-rename-file-out-of-band
                :around (lambda (orig-fun &rest args)
                          (let ((default-directory "/"))
                            (dolist (pos '(1 2))
                              (unless (tramp-tramp-file-p (nth pos args))
                                (setf (nth pos args)
                                      (substring (shell-command-to-string
                                                  (concat "cygpath -u "
                                                          (shell-quote-argument (nth pos args))))
                                                 0 -1)))))
                          (apply orig-fun args)))

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
