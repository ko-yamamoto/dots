(use-package markdown-mode
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

  (setq markdown-command "markdown")
  (setq markdown-command-needs-filename t)

  ;; 行末スペースは HTML に変換した際の改行に必要なので消さないように
  (remove-hook 'before-save-hook 'delete-trailing-whitespace)

  ;; ヘッダは左にだけ#をつける
  (setq markdown-asymmetric-header t)

  ;; (defun markdown-render-eww (n)
  ;;   (interactive "p")
  ;;   (message (buffer-file-name))
  ;;   (call-process "/usr/local/bin/grip" nil nil nil
  ;;                 "--gfm" "--export"
  ;;                 (buffer-file-name)
  ;;                 "/mnt/c/my/tmp/grip.html")
  ;;   (eww-open-file "/mnt/c/my/tmp/grip.html"))

  (use-package markdown-preview-mode
    :defer t
    :config
    (setq markdown-preview-stylesheets
          (list "https://rawgit.com/andyferra/2554919/raw/10ce87fe71b23216e3075d5648b8b9e56f7758e1/github.css")))

  (bind-keys :map markdown-mode-map
             ("C-c C-c" . markdown-preview-mode)
             ("M-<up>" . drag-stuff-up)
             ("M-<down>" . drag-stuff-down)))
