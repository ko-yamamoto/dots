;; Run `sbt ensimeConfig`
;; (use-package ensime
;;   :straight (:host github :repo "ensime/ensime-emacs"
;;              :branch "2.0")
;;   :config
;;   (setq ensime-startup-notification nil)
;;   (setq ensime-search-interface 'helm)
;;   (bind-keys :map ensime-mode-map
;;              ("M-n" . nil) ;; use highlight-symbol-nav
;;              ("M-p" . nil)) ;; use highlight-symbol-nav
;;   )

(use-package scala-mode
  :interpreter
  ("scala" . scala-mode)
  :config
  (setq scala-indent:use-javadoc-style t))


;; lsp-mode for metals
;; https://scalameta.org/metals/docs/editors/emacs.html ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enable sbt mode for executing sbt commands
(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
   (setq sbt:program-options '("-Dsbt.supershell=false"))
   )

;; Add metals backend for lsp-mode
(use-package lsp-metals
  :config (setq lsp-metals-treeview-show-when-views-received t))
