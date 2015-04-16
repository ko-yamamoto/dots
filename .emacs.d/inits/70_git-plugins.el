;; vcを起動しないようにする
(custom-set-variables
 '(vc-handled-backends nil))

;; 不要なhookを外す
(remove-hook 'find-file-hook 'vc-find-file-hook)
(remove-hook 'kill-buffer-hook 'vc-kill-buffer-hook)

(use-package magit
  :defer t
  :ensure t
  :bind (("C-c g g" . magit-status)
         ("C-c g d" . magit-diff-working-tree)
         ("C-c g f" . magit-file-log))
  :config

  ;; 起動時に表示される 1.4 から挙動注意の警告をとめる
  (setq magit-last-seen-setup-instructions "1.4.0")

  (defun my/git-commit-commit ()
    (interactive)
    (git-commit-commit)
    (elscreen-kill))

  (defun my/magit-quit-session ()
    (interactive)
    (magit-mode-quit-window)
    (delete-window))

  ;; 色変更
  ;; (set-face-foreground 'magit-diff-add "#b9ca4a")
  ;; (set-face-background 'magit-diff-add "#000000")
  ;; (set-face-foreground 'magit-diff-del "#d54e53")
  ;; (set-face-background 'magit-diff-del "#000000")
  ;; (set-face-background 'magit-item-highlight "#000000")

  (bind-keys :map git-commit-mode-map
             ("C-c C-c" . my/git-commit-commit))

  (bind-keys :map magit-status-mode-map
             ("q" . my/magit-quit-session))

  )


(use-package git-commit-mode
  :ensure t)


(use-package git-gutter+
  :ensure t
  :defer t
  :bind (("C-c g c" . global-git-gutter+-mode))
  :config
  (global-git-gutter+-mode t)
  ;; 指定したモードで有効に
  ;; (let ((mode-hooks
         ;; '(org-mode-hook
           ;; rst-mode-hook
           ;; java-mode-hook
           ;; lisp-mode-hook
           ;; clojure-mode-hook
           ;; scala-mode-hook
           ;; haskell-mode-hook
           ;; sh-mode-hook
           ;; go-mode-hook
           ;; python-mode-hook
           ;; ruby-mode-hook)))
    ;; (mapc (lambda (mode-hook) (add-hook mode-hook 'git-gutter+-mode)) mode-hooks))

  ;; 表示変更
  (setq git-gutter+-window-width 1)
  (setq git-gutter+-modified-sign "|")
  (setq git-gutter+-added-sign "|")
  (setq git-gutter+-deleted-sign "|")

  ;; 色変更
  (set-face-foreground 'git-gutter+-modified "#eab700")
  (set-face-foreground 'git-gutter+-added "#95D9FF")
  (set-face-foreground 'git-gutter+-deleted "#c82829")

  ;; Ignore all spaces
  ;; (setq git-gutter+-diff-options '("-w"))

  )

(use-package fringe-helper :ensure t)

(use-package git-gutter-fringe+
  :ensure t
  :defer t
  :config
  (setq-default left-fringe-width  10)
  (setq-default right-fringe-width 10)
  ;; 形変更 (上下くっつけるため目一杯長く)
  (fringe-helper-define 'git-gutter-fr+-added nil
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX")
  (fringe-helper-define 'git-gutter-fr+-deleted nil
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX")
  (fringe-helper-define 'git-gutter-fr+-modified nil
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX"
    "XXXXXXXXX")

  )
