(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))

;; brew install rust-analyzer
(use-package rustic
  :config
  (setq-default rustic-format-trigger 'on-save)
  (setq rustic-lsp-server 'rust-analyzer))


