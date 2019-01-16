(use-package flycheck
  :bind(("C-q f l" . flycheck-list-errors))
  ;; :init (global-flycheck-mode)
  :config

  ;; textlint
  (flycheck-define-checker textlint
    "A linter for Markdown."
    :command ("textlint" "--format" "unix" source)
    :error-patterns
    ((warning line-start (file-name) ":" line ":" column ": "
              (id (one-or-more (not (any " "))))
              (message (one-or-more not-newline)
                       (zero-or-more "\n" (any " ") (one-or-more not-newline)))
              line-end))
    :modes (text-mode markdown-mode gfm-mode))
  (add-hook 'markdown-mode-hook
            '(lambda ()
               (setq flycheck-checker 'textlint)
               (flycheck-mode 1))))
