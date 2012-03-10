;; color-themeの設定
(require 'color-theme)
(color-theme-initialize)
;; (color-theme-andreas)
;; (color-theme-ns-w2)
;; (color-theme-ns)
;; (color-theme-tangotango)
;; (color-theme-tomorrow-night-bright)
(color-theme-tomorrow-night)
;; (color-theme-tomorrow)

;; ウィンドウを透明化
(add-to-list 'default-frame-alist '(alpha . (0.85 0.85)))

;; キーワードのカラー表示を有効化
(global-font-lock-mode t)

;; 選択範囲をハイライト
(setq-default transient-mark-mode t)


