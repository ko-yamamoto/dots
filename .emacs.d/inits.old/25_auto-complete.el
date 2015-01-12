(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

;; 補完メニュー表示時に特別なキーマップを有効にするか
(setq ac-use-menu-map t)
;; 辞書ファイルの位置
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;; 補完の開始キー
(define-key ac-mode-map (kbd "M-c") 'auto-complete)
;; 補完を止めるキー
(define-key ac-menu-map "q" 'ac-stop)
;; 補完メニュー表示までのディレイ
(setq ac-auto-show-menu 0.3)
;;補完メニューの行数
(setq ac-menu-height 15)
;; 大文字・小文字の区別方法
(setq ac-ignore-case 'smart)
;; 補完選択時にTABをRETの挙動にしない
(setq ac-dwim nil)
;; 表示崩れ防止
;; (setq popup-use-optimized-column-computation nil)

;; 追加モード
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'gfm-mode)


(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))
