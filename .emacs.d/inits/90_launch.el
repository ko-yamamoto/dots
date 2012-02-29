;; ---------------------------------------------------------------------------------
;; launch Settings
;; ---------------------------------------------------------------------------------
(add-hook 'after-init-hook
          (lambda()
;;            (eshell)
            (switch-to-buffer "*scratch*")
            (rst-mode)
            (wrap-region-mode)
))
