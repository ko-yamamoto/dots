(use-package ddskk
  :ensure t
;  :defer t
  ;; :bind (("C-q s s" . skk-mode))
  :init
  (require 'ccc)
  (key-chord-define-global "jk" 'skk-mode))

;; config -> ~/.skk
