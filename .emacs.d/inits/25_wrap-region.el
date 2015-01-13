(use-package wrap-region
  :ensure t
  :config
  (wrap-region-global-mode t)
  )

;; 第一引数:リージョンの先頭に挿入する文字
;; 第二引数:リージョン末尾に挿入する文字
;; 第三引数:トリガとなるキー
;; 第四引数:有効にするモード
;; (wrap-region-add-wrapper "(" ")" "(")
