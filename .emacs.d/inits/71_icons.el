(require 'font-lock+)
(use-package all-the-icons
  :ensure t)

(use-package all-the-icons-dired
  :ensure t
  :defer t ; M-x all-the-icons-install-fonts
  :hook (dired-mode . all-the-icons-dired-mode)
  ;; font-lock+ が必要
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
  )

;;;dired-sidebar
(use-package dired-sidebar
  :bind
  ("C-S-e" . dired-sidebar-toggle-sidebar)
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  ;; (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  ;; (push 'rotate-windows dired-sidebar-toggle-hidden-commands)
  (setq dired-sidebar-face '(:height 90))
  (setq dired-sidebar-subtree-line-prefix "  ")
  (setq dired-sidebar-theme 'icons)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))


;; (use-package neotree
;;   :ensure t
;;   :bind ("C-S-e" . neotree-toggle)
;;   :config
;;   (setq neo-smart-open t)
;;   (setq neo-autorefresh t)
;;   (setq neo-window-width 35)
;;   (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))
