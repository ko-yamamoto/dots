(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)

;; (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))

;; (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
(setq markdown-command "mdown") ;; npm install gh-markdown-cli -g
