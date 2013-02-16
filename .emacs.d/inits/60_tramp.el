;; (add-to-list 'load-path "~/.emacs.d/elisp/tramp-2.2.6/lisp/")
(require 'tramp)

;; (setq-default tramp-default-method "sshx")
(setq-default tramp-default-method "scpc")

;; 再接続用ファイルは作らない -> Solaris でエラーが出るため
(setq-default tramp-persistency-file-name nil)


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



(defun my-tramp-closing ()
  "tramp のバッファを全て閉じ、全接続を終了する"
  (interactive)
   (tramp-cleanup-all-buffers)
   (tramp-cleanup-all-connections))
