(use-package point-undo
  :ensure t
  :defer t
  :bind (("<f7>" . point-undo)
         ("S-<f7>" . point-redo)))

(use-package goto-chg
  :ensure t
  :defer t
  :bind (("<f8>" . goto-last-change)
         ("S-<f8>" . goto-last-change-reverse)))
