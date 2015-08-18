;;====================
;; haskell-mode
;;====================

;; (load "~/.emacs.d/el-get/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;; (add-to-list 'auto-mode-alist '("\\.hs" . haskell-mode))
;; (add-to-list 'auto-mode-alist '("\\.lhs" . literate-haskell-mode))
;; (add-to-list 'auto-mode-alist '("\\.cabal" . haskell-cabal-mode))

;; ghc-mod
;; cabal でインストールしたライブラリのコマンドが格納されている bin ディレクトリへのパスを exec-path に追加する
(add-to-list 'exec-path (concat (getenv "HOME") "/.cabal/bin"))
;; ghc-flymake.el などがあるディレクトリ ghc-mod
;; (add-to-list 'load-path "~/.emacs.d/elisp/ghc-mod-1.10.15")
;; (autoload 'ghc-init "ghc" nil t)
;; (add-hook 'haskell-mode-hook
;;           (lambda () (ghc-init)))

;; auto-complete
(ac-define-source ghc-mod
  '((depends ghc)
    (candidates . (ghc-select-completion-symbol))
    (symbol . "s")
    (cache)))

;; indent
(remove-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(remove-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(defun my-haskell-mode-hook ()
  (haskell-indentation-mode -1) ;; turn off, just to be sure
  (haskell-indent-mode 1))      ;; turn on indent-mode
(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)


(defun my-ac-haskell-mode ()
  (setq ac-sources '(ac-source-words-in-same-mode-buffers ac-source-dictionary ac-source-ghc-mod)))
(add-hook 'haskell-mode-hook 'my-ac-haskell-mode)

(defun my-haskell-ac-init ()
  (when (member (file-name-extension buffer-file-name) '("hs" "lhs"))
    (auto-complete-mode t)
    (setq ac-sources '(ac-source-words-in-same-mode-buffers ac-source-dictionary ac-source-ghc-mod))))

(add-hook 'haskell-mode-hook 'my-haskell-ac-init)


;; (require 'auto-complete-haskell)
