(require 'go-mode)

(add-to-list 'auto-mode-alist '("\\.go$" . go-mode))
;; go get code.google.com/p/rog-go/exp/cmd/godef
(add-hook 'go-mode-hook (lambda ()
                          (setq c-basic-offset 4)
                          (setq indent-tabs-mode t)
                          ;; 保存時に自動 fmt
                          (add-hook 'before-save-hook 'gofmt-before-save)

                          ;; GOPATH を Emacs から扱えるように exec-path へ追加しておくこと
                          (require 'go-autocomplete)
                          (require 'auto-complete-config)

                          ;; (local-set-key (kbd "M-." 'godef-jump))
                          ;; (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
                          ;; (local-set-key (kbd "C-c i") 'go-goto-imports)
                          ;; (local-set-key (kbd "C-c d") 'godoc))
                          ))
