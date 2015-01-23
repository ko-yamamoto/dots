(use-package markdown-mode
  :ensure t
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

  ;; grip コマンドラッパーでの HTML プレビュー用
  ;; EmacsでGithub flavorなMarkdownをプレビューできるようにする - cloverrose's blog - http://cloverrose.hateblo.jp/entry/2014/11/03/220452
  (setq markdown-command "markdown")
  (setq markdown-command-needs-filename t)

  ;; 行末スペースは HTML に変換した際の改行に必要なので消さないように
  (remove-hook 'before-save-hook 'delete-trailing-whitespace)

  (defun markdown-render-eww (n)
    (interactive "p")
    (message (buffer-file-name))
    (call-process "/usr/local/bin/grip" nil nil nil
                  "--gfm" "--export"
                  (buffer-file-name)
                  "/tmp/grip.html")
    (eww-open-file "/tmp/grip.html"))

  (defun markdown-render-browser (n)
    (interactive "p")
    (message (buffer-file-name))
    (call-process "/usr/local/bin/grip" nil nil nil
                  "--gfm" "--export"
                  (buffer-file-name)
                  "/tmp/grip.html")
    (browse-url-of-file "/tmp/grip.html"))

  (bind-keys :map markdown-mode-map
             ("M-n" . linum-mode) ;; デフォルトキーバインドを上書き
             ("C-c C-c" . markdown-render-browser)))
