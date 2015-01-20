(require 'magit)

;; magit をバッファ全体に開く
;; (setq magit-status-buffer-switch-function 'switch-to-buffer)

(require 'vc)
;; (defun magit-status-with-new-elscreen ()
;;   "新しい elscreen で magit status"
;;   (interactive)
;;   (setq my/now-point (buffer-file-name))
;;   (elscreen-create)
;;   (magit-status
;;    (vc-call-backend (vc-responsible-backend my/now-point) 'root my/now-point))
;;   (delete-other-windows))

(defun my/git-commit-commit ()
  (interactive)
  (git-commit-commit)
  (elscreen-kill))
(define-key git-commit-mode-map (kbd "C-c C-c") 'my/git-commit-commit)

;; (defun my/magit-quit-session ()
;;   (interactive)
;;   (elscreen-kill-screen-and-buffers))
;; (define-key magit-status-mode-map (kbd "q") 'my/magit-quit-session)
(defun my/magit-quit-session ()
  (interactive)
  (magit-mode-quit-window)
  (delete-window))
(define-key magit-status-mode-map (kbd "q") 'my/magit-quit-session)

;; (global-set-key (kbd "C-c g g") 'magit-status-with-new-elscreen)
(global-set-key (kbd "C-c g g") 'magit-status)
(global-set-key (kbd "C-c g d") 'magit-diff-working-tree)
(global-set-key (kbd "C-c g f") 'magit-file-log)

;; 色変更
;; (set-face-foreground 'magit-diff-add "#b9ca4a")
;; (set-face-background 'magit-diff-add "#000000")
;; (set-face-foreground 'magit-diff-del "#d54e53")
;; (set-face-background 'magit-diff-del "#000000")
;; (set-face-background 'magit-item-highlight "#000000")
