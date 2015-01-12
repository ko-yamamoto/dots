(use-package magit
  :ensure t
  :bind (("C-c g g" . magit-status)
         ("C-c g d" . magit-diff-working-tree)
         ("C-c g f" . magit-file-log))
  :config

  (require 'vc)

  (defun my/git-commit-commit ()
    (interactive)
    (git-commit-commit)
    (elscreen-kill))
  (define-key git-commit-mode-map (kbd "C-c C-c") 'my/git-commit-commit)

  (defun my/magit-quit-session ()
    (interactive)
    (magit-mode-quit-window)
    (delete-window))
  (define-key magit-status-mode-map (kbd "q") 'my/magit-quit-session)

  ;; 色変更
  ;; (set-face-foreground 'magit-diff-add "#b9ca4a")
  ;; (set-face-background 'magit-diff-add "#000000")
  ;; (set-face-foreground 'magit-diff-del "#d54e53")
  ;; (set-face-background 'magit-diff-del "#000000")
  ;; (set-face-background 'magit-item-highlight "#000000")
  )
