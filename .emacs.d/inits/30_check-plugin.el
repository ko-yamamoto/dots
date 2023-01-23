(use-package flycheck
  ;; npm install --global textlint textlint-rule-preset-ja-spacing textlint-rule-preset-ja-technical-writing textlint-rule-no-mix-dearu-desumasu
  ;; :bind(("C-q f l" . flycheck-list-errors))
  ;; :init (global-flycheck-mode)
  :config
  ;; エラーリストの表示設定
  (add-to-list 'display-buffer-alist
               `(,(rx bos "*Flycheck errors*" eos)
                 (display-buffer-reuse-window
                  display-buffer-in-side-window)
                 (side            . bottom)
                 (reusable-frames . visible)
                 (window-height   . 0.20)))

  ;; エラーリストのカラム幅を変更
  (defconst flycheck-error-list-format [("File" 25)
                                        ("Line" 5 flycheck-error-list-entry-< :right-align t)
                                        ("Col" 4 nil :right-align t)
                                        ("Level" 30 flycheck-error-list-entry-level-<)
                                        ("ID" 6 t)
                                        (#("Message (Checker)" 0 7
                                           (face flycheck-error-list-error-message)
                                           9 16
                                           (face flycheck-error-list-checker-name))
                                         0 t)])

  (add-hook 'flycheck-mode-hook #'flycheck-set-indication-mode)

  ;; php
  (use-package flycheck-phpstan :ensure t)

  ;; textlint
  (flycheck-define-checker textlint
    "A linter for Markdown."
    :command ("textlint.sh" source)
    :error-patterns
    ((warning line-start (file-name) ":" line ":" column ": "
              (id (one-or-more (not (any " "))))
              (message (one-or-more not-newline)
                       (zero-or-more "\n" (any " ") (one-or-more not-newline)))
              line-end))
    :modes (text-mode markdown-mode gfm-mode org-mode)))

