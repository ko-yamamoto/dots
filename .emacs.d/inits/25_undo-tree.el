(use-package undo-tree
  :ensure t
  :defer t
  :bind (("C-/" . undo-tree-undo)
         ("M-/" . undo-tree-redo))
  :config
  (global-undo-tree-mode)
  ;; デフォルトで時間を表示
  (setq undo-tree-visualizer-timestamps t)

  (global-set-key (kbd "C-/") 'undo-tree-undo)
  (global-set-key (kbd "M-/") 'undo-tree-redo)
  )
