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

  ;; エラーリストのカラム幅を無理矢理変更する
  (add-hook 'flycheck-error-list-mode-hook
            (lambda ()
              (setq tabulated-list-format '[("Line" 5 flycheck-error-list-entry-< :right-align t)
                                            ("Col" 20 nil :right-align t)
                                            ("Level" 10 flycheck-error-list-entry-level-<)
                                            ("ID" 20 t)
                                            (#("Message (Checker)" 0 9
                                               (face default)
                                               9 16
                                               (face flycheck-error-list-checker-name)
                                               16 17
                                               (face default))
                                             0 t)])))

  (add-hook 'flycheck-mode-hook #'flycheck-set-indication-mode)

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
