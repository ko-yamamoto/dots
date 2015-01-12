(require 'swoop)
;; (global-set-key (kbd "C-o")   'swoop)
;; (global-set-key (kbd "C-M-o") 'swoop-multi)
;; (global-set-key (kbd "M-o")   'swoop-pcre-regexp)
;; (global-set-key (kbd "C-S-o") 'swoop-back-to-last-position)
;; (global-set-key (kbd "H-6")   'swoop-migemo) ;; Option for Japanese match
; Swoop Edit Mode
;; During swoop, press [C-c C-e]
;; You can edit buffers synchronously.

(defvar swoop-migemo-options
  "-q -e -d /usr/local/share/migemo/utf-8/migemo-dict")

;Transition
;; isearch     > press [C-o] > swoop
;; evil-search > press [C-o] > swoop
;; swoop       > press [C-o] > swoop-multi
;; (define-key isearch-mode-map (kbd "C-o") 'swoop-from-isearch)
(define-key isearch-mode-map (kbd "C-o") 'my/swoop-from-isearch-migemo)
;; (define-key evil-motion-state-map (kbd "C-o") 'swoop-from-evil-search)
(define-key swoop-map (kbd "C-o") 'swoop-multi-from-swoop)

;; migemo を使う
(defun my/swoop-from-isearch-migemo ()
  (interactive)
  (setq swoop-use-migemo t)
  (swoop-from-isearch))

;; helm-soop ではなく emacs-swoop を利用
(setq ace-isearch-funtion-from-isearch 'my/swoop-from-isearch-migemo)
(define-key swoop-map (kbd "C-s") 'swoop-action-goto-line-next)
(define-key swoop-map (kbd "C-r") 'swoop-action-goto-line-prev)
