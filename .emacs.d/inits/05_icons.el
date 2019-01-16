(require 'font-lock+)
(use-package all-the-icons)

(use-package all-the-icons-dired
  ;; :defer t ; M-x all-the-icons-install-fonts
  :hook (dired-mode . all-the-icons-dired-mode)
  ;; font-lock+ が必要
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
  )

(use-package neotree
  :bind ("C-S-e" . neotree-toggle)
  :config
  (setq neo-smart-open t)
  (setq neo-autorefresh t)
  (setq neo-window-width 45)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  ;; フレームの右に表示する
  (setq neo-window-position 'right)
  ;; vcの状態を色で表示
  (setq neo-vc-integration '(face))
  ;; neotreeのバッファに行数を表示しない
  (add-hook 'neo-after-create-hook (lambda (&rest _) (display-line-numbers-mode -1)))
  ;; フォントを小さくして表示
  (defun text-scale-twice ()(interactive)(progn(text-scale-adjust 0)(text-scale-decrease 1)))
  (add-hook 'neo-after-create-hook (lambda (_)(call-interactively 'text-scale-twice)))

  (bind-keys :map neotree-mode-map
             ("." . neotree-hidden-file-toggle)
             ("^" . neotree-select-up-node)
             ("w" . neotree-copy-filepath-to-yank-ring)
             ("R" . neotree-rename-node)
             ("D" . neotree-delete-node)
             ("+" . neotree-create-node)))
