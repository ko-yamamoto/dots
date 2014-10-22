;;====================
;; For Linux
;;====================

(when is_linux

  ;; exec-pathとPATHに設定したいパスのリストを設定
  (dolist (dir (list
                "/usr/local/bin"
                "/usr/local/scala/bin"
                "~/bin"
                "/sbin"
                "/usr/sbin"
                "/bin"
                "/usr/bin"
                (expand-file-name "~/bin")
                (expand-file-name "~/.emacs.d/bin")
                ))
    ;; PATH と exec-path に同じ物を追加
    (when (and (file-exists-p dir) (not (member dir exec-path)))
      (setenv "PATH" (concat dir ":" (getenv "PATH")))
      (setq exec-path (append (list dir) exec-path))))

  ;; リンクを開くブラウザの設定
  (setq browse-url-browser-function 'browse-url-generic
        browse-url-generic-program "google-chrome-unstable")

  ;; (setq x-super-keysym 'meta)
  ;; (setq x-meta-keysym  'super)

 )
