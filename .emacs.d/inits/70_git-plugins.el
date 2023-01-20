(use-package magit
  :defer t
  :bind (("C-x g" . magit-status))
  :config
  ;; 色変更
  ;; (set-face-foreground 'magit-diff-add "#b9ca4a")
  ;; (set-face-background 'magit-diff-add "#000000")
  ;; (set-face-foreground 'magit-diff-del "#d54e53")
  ;; (set-face-background 'magit-diff-del "#000000")
  ;; (set-face-background 'magit-item-highlight "#000000")

  (defun my/commit-cancel ()
    (interactive)
    (with-editor-cancel t)
    (elscreen-kill))

  (defun my/commit-finish ()
    (interactive)
    (with-editor-finish t)
    (elscreen-kill))


  (when is_winnt
    ;; msys2 から Git for Windows の git.exe を使うと commit 時の emacsclient のパスが壊れるため
    (setq with-editor-emacsclient-executable "emacsclient"))

  (bind-keys :map git-commit-mode-map
             ("C-c C-c" . my/commit-finish)
             ("C-c C-k" . my/commit-cancel))

  )

(use-package git-gutter
  :bind (("C-c g c" . git-gutter:update-all-windows)
         ("C-c g n" . git-gutter:next-hunk)
         ("C-c g p" . git-gutter:previous-hunk)
         ("C-c g d" . git-gutter:popup-hunk)
         ("C-c g e" . git-gutter:end-of-hunk))
  :config
  (global-git-gutter-mode t)
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
  ;; (mapc (lambda (mode-hook) (add-hook mode-hook 'git-gutter-mode)) mode-hooks))

  ;; 表示変更
  (setq git-gutter-window-width 1)
  (setq git-gutter-modified-sign "|")
  (setq git-gutter-added-sign "|")
  (setq git-gutter-deleted-sign "|")

  ;; ;; 色変更 → カラーテーマで設定
  ;; (set-face-foreground 'git-gutter:modified "#D19A66") ; orange
  ;; (set-face-foreground 'git-gutter:added "#61AFEF") ; blue
  ;; (set-face-foreground 'git-gutter:deleted "#E06C75") ; red

  ;; Ignore all spaces
  ;; (setq git-gutter-diff-options '("-w"))

  ;; magitのステータス更新時にあわせてgit-gutterも更新する
  (add-hook 'magit-post-refresh-hook 'git-gutter:update-all-windows)

  )

(use-package git-gutter-fringe
  :config
  (use-package fringe-helper)
  (setq-default left-fringe-width  10)
  (setq-default right-fringe-width 10)

  ;; 形変更 (上下くっつけるため目一杯長く)
  (fringe-helper-define 'git-gutter-fr:added nil
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
  (fringe-helper-define 'git-gutter-fr:deleted nil
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
  (fringe-helper-define 'git-gutter-fr:modified nil
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

(use-package blamer
  :ensure t
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  (blamer-pretty-time-p t)
  (blamer-author-formatter "✎ %s ")
  (blamer-datetime-formatter "[%s] ")
  (blamer-commit-formatter "● %s")
  (blamer-type 'visual)
  :config
  (global-blamer-mode 1))

(use-package github-browse-file
  :ensure t)

