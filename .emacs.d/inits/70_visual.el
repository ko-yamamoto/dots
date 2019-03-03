;;====================
;; フォント
;;====================

;; 01234567890123456789
;;  あいうえおかきくけこ
;;   abcdefghijklmnopqrstuvwxyz
;; 下の縦棒が揃うこと
;; | 数字 | アルファベット | 日本語     |
;; | 0123 | abcdefghijklmn | こんにちは |

(when is_wsl
  (set-face-attribute 'default nil :family "Noto Sans Mono CJK JP" :height 110 :weight 'regular)
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    (font-spec :family "Noto Sans Mono CJK JP")))

;; (when is_linux
;; (set-face-attribute 'default nil :family "M+ 1mn regular" :height 137 :weight 'regular)
;; (set-fontset-font (frame-parameter nil 'font)
;; 'japanese-jisx0208
;; (font-spec :family "M+ 1mn"))
;; (add-to-list 'face-font-rescale-alist
;; '(".*Gen.*" . 1.1)))

;; (when is_win
;; (set-face-attribute 'default nil :family "M+ 1mn" :height 110 :weight 'regular)
;; (set-fontset-font (frame-parameter nil 'font)
;; 'japanese-jisx0208
;; "-outline-源暎ゴシックM SemiLight-light-normal-normal-mono-12-*-*-*-c-*-fontset-auto3")
;;   )

;; (when is_mac
;;   (set-face-attribute 'default nil :family "M+ 1mn" :height 110 :weight 'light)
;;   (set-fontset-font (frame-parameter nil 'font)
;;                     'japanese-jisx0208
;;                     (font-spec :family "M+ 1mn"))
;;   (add-to-list 'face-font-rescale-alist
;;                '(".*M+ 1mn.*" . 1.0)))


(use-package volatile-highlights
  :config
  (volatile-highlights-mode t))

(use-package polymode
  :config
  (use-package poly-markdown
    :config
    (add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))))

;; color-themeの設定
(require 'color-theme)
(color-theme-initialize)
;; (color-theme-sanityinc-tomorrow-day)

;; after emacs24
(setq custom-theme-directory "~/.emacs.d/themes/")
(load-theme 'atom-one-dark t)

;; バッファの終端をtなら明示するnilならしない
(setq-default indicate-empty-lines nil)

;; タイトルバー
(setq frame-title-format (format "%%f - Emacs@%s" (system-name)))

;; 対応するカッコをハイライト
(show-paren-mode 1)

;; ハイライト
(transient-mark-mode t)

;; カーソル点滅
(blink-cursor-mode t)

;; カーソル行ハイライト
(global-hl-line-mode)
;; (use-package hl-line+
;;   ;; :defer t
;;   :config
;;   ;; 一定時間後に現在行ハイライト
;;   (toggle-hl-line-when-idle)
;;   ;; n 秒後に変更
;;   (hl-line-when-idle-interval 10))

;; カーソルの形
(set-default 'cursor-type '(hbar . 5))

;; カーソル位置のフェースを調べる関数
(defun describe-face-at-point ()
  "Return face used at point."
  (interactive)
  (message "%s" (get-char-property (point) 'face)))

;; tで折り返さないnilなら折り返す
(setq truncate-lines t)
;; 画面分割してもデフォルトで折り返す
(setq truncate-partial-width-windows nil)

;; 折り返し表示をトグル
(defun toggle-truncate-lines ()
  "折り返し表示をトグル動作します."
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t)))
(global-set-key (kbd "C-c l") 'toggle-truncate-lines) ; 折り返し表示ON/OFF

;; 行数表示
(if (version<= "26.0.50" emacs-version)
      (global-display-line-numbers-mode))

;; ツールバーを消す
(tool-bar-mode 0)
(menu-bar-mode -1)

;; スクロールバーを消す
(set-scroll-bar-mode nil)
(horizontal-scroll-bar-mode -1)

;; タブ, 全角スペース, 行末空白表示
(defface my-face-b-1 '((t (:underline (:style wave :color "#f2777a")))) nil) ; 全角スペース
(defface my-face-b-2 '((t (:underline (:style wave :color "#f2777a")))) nil) ; タブ
(defface my-face-u-1 '((t (:underline (:style wave :color "#f2777a")))) nil) ; 行末空白
(defface my-face-u-1 '((t (:underline (:style wave :color "#f2777a")))) nil) ; 行末空白
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)

(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(
     ;; ("\t" 0 my-face-b-2 append)
     ("　" 0 my-face-b-1 append)
     ("[ \t]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;; ウィンドウを透明化
(set-frame-parameter nil 'alpha 75)

;; キーワードのカラー表示を有効化
(global-font-lock-mode t)

;; 選択範囲をハイライト
(setq-default transient-mark-mode t)


(use-package dimmer
  :config
  (setq dimmer-fraction 0.4)
  (setq dimmer-exclusion-regexp "^\\*helm\\|^ \\*Minibuf\\|^\\*Calendar")
  (dimmer-mode))

