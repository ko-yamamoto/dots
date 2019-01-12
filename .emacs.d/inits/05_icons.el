(require 'font-lock+)
(use-package all-the-icons)

(use-package all-the-icons-dired
  ;; :defer t ; M-x all-the-icons-install-fonts
  :hook (dired-mode . all-the-icons-dired-mode)
  ;; font-lock+ が必要
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
  )

;; (use-package neotree
;;   :bind ("C-S-e" . neotree-toggle)
;;   :config
;;   (setq neo-smart-open t)
;;   (setq neo-autorefresh t)
;;   (setq neo-window-width 35)
;;   (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))
