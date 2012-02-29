;;====================
;; nxhtml
;;====================
;; 重いので普段は使わない -> html-modeで十分
;;(load "~/.emacs.d/elisp/nxhtml/autostart.el")
;;(add-hook 'nxml-mode-hook
;;          '(lambda ()
;;             (local-set-key (kbd "C-c C-c") 'nxml-complete)))
(add-hook 'nxml-mode-hook
          (lambda ()
            (setq auto-fill-mode -1)
            ;; スラッシュの入力で終了タグを自動補完
            (setq nxml-slash-auto-complete-flag t)
            ;; タグのインデントをしない
            ;; (setq nxml-child-indent 0)
            ;; (setq indent-tabs-mode t)
            (setq tab-width 4)))

