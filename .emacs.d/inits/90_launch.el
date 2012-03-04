;; ---------------------------------------------------------------------------------
;; launch Settings
;; ---------------------------------------------------------------------------------
;; 折り返しあり
(setq truncate-lines nil)
;; 画面分割してもデフォルトで折り返す
(setq truncate-partial-width-windows nil)


(add-hook 'after-init-hook
          (lambda()
;;            (eshell)
;;            (switch-to-buffer "*scratch*")
            (rst-mode)
            (wrap-region-global-mode t)
            (howm-menu)))
