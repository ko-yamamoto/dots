(require 'cedet)
;; (setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
;;                                   global-semanticdb-minor-mode
;;                                   global-semantic-idle-summary-mode
;;                                   global-semantic-mru-bookmark-mode))
;; (semantic-mode 1)

;; (semantic-load-enable-excessive-code-helpers)

;; imenu 時の表示を変更
;; (setq semantic-imenu-summary-function
;;       (lambda (tag)
;;         (semantic-format-tag-summarize tag nil t)))

;; speedbarを使う
(require 'semantic-sb)
(require 'sr-speedbar)
(define-key global-map (kbd "C-q C-s") 'sr-speedbar-toggle)

;; 画像を表示しない
(setq speedbar-use-images nil)

(add-hook 'speedbar-reconfigure-keymaps-hook
          '(lambda ()
             (define-key speedbar-key-map "a" 'speedbar-toggle-show-all-files)
             (define-key speedbar-key-map [right] 'speedbar-expand-line)
             ;; (define-key speedbar-file-key-map [left] 'speedbar-up-directory)
             ;; (define-key speedbar-buffer-key-map [left] 'speedbar-contract-line)
             (define-key speedbar-key-map (kbd "C-t") 'other-window)
             (define-key speedbar-key-map (kbd "b") (lambda () (interactive) (speedbar-change-initial-expansion-list "buffers")))
             )
          )


(require 'semantic-imenu)
