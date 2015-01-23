(use-package ido
  :defer t
  :bind (("C-x C-b" . ido-switch-buffer)
         ("M-y" . kill-ring-insert)
         ("C-;" . recentf-ido-find-file))
  :config
  ;; あいまいマッチ
  (setq ido-enable-flex-matching t)

  (setq ido-max-window-height 0.75)

  (ido-mode 1)

  ;; ido で最近開いたファイルとディレクトリを選択
  (defun recentf-ido-find-file ()
    "Find a recent file using Ido."
    (interactive)
    (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
      (when file
        (find-file file))))

  ;; kill ring を ido で
  (defun kill-ring-insert ()
    (interactive)
    (let ((to_insert (ido-completing-read "Yank : "
                                          (delete-duplicates kill-ring :test #'equal))))
      (when (and to_insert (region-active-p))
        ;; the currently highlighted section is to be replaced by the yank
        (delete-region (region-beginning) (region-end)))
      (insert to_insert)))
  )

(use-package ido-vertical-mode
  :ensure t
  :config (ido-vertical-mode 1))

(use-package smex
  ;; M-x を ido で
  :ensure t
  :defer t
  :init (smex-initialize)
  :bind ("M-x" . smex))

(use-package ido-ubiquitous
  :ensure t
  ;; どこでも ido
  :config
  (ido-ubiquitous-mode 1)
  ;; C-j を skk-mode にする
  (when (fboundp 'skk-mode)
    (fset 'ido-select-text 'skk-mode)))

(use-package imenu-anywhere
  ;; imenu を同一メジャーモードのマルチバッファ化
  :ensure t
  :defer t
  :bind (("M-i" . ido-imenu-anywhere)))
