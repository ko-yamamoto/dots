;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package eglot
  :straight (:type built-in)
  :config
  ;; scala
  (add-hook 'scala-mode-hook 'eglot-ensure)
  ;; php
  (add-to-list 'eglot-server-programs '(php-mode "intelephense" "--stdio"))
  (add-hook 'php-mode-hook 'eglot-ensure)
)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package lsp-mode
;;   :commands (lsp lsp-deferred)
;;   :hook
;;   (lsp-mode . lsp-lens-mode)
;;   (scala-mode . lsp-deferred)
;;   (php-mode . (lambda ()
;;                 (lsp-deferred)
;;                 (flycheck-add-next-checker 'lsp 'phpstan)))
;;   (terraform-mode . lsp-deferred) ;; brew install hashicorp/tap/terraform-ls
;;   :bind
;;   ("<f12>" . lsp-find-references)
;;   :init
;;   (setq lsp-keymap-prefix "C-c l")
;;   :custom
;;   (lsp-file-watch-threshold 10000)
;;   :config
;;   (setq lsp-prefer-flymake nil)
;;   (lsp-headerline-breadcrumb-mode t)
;;   (setf lsp-prefer-capf t)
;;   (setq lsp-ui-doc-enable t)
;;   (setq lsp-ui-doc-header t)
;;   (setq lsp-ui-doc-include-signature t)
;;   (setq lsp-ui-doc-position 'top)
;;   (setq lsp-ui-imenu-enable t)
;;   ;; (setq lsp-completion-provider :none) ;; use corfu.el

;;   ;; (defun my/lsp-mode-setup-completion ()
;;   ;;   (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
;;   ;;         '(orderless))) ;; Configure orderless
;;   ;; (add-hook 'lsp-completion-mode-hook #'my/lsp-mode-setup-completion)
;;   )


;; ;; Enable nice rendering of documentation on hover
;; (use-package lsp-ui)

;; ;; Use the Debug Adapter Protocol for running tests and debugging
;; (use-package posframe
;;   ;; Posframe is a pop-up tool that must be manually installed for dap-mode
;;   )
;; ;; (use-package dap-mode
;; ;;   :hook
;; ;;   (lsp-mode . dap-mode)
;; ;;   (lsp-mode . dap-ui-mode)
;; ;;   )


