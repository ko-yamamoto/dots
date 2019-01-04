;;====================
;; フォント
;;====================

;; 01234567890123456789
;;  あいうえおかきくけこ
;;   abcdefghijklmnopqrstuvwxyz
;; 下の縦棒が揃うこと
;; | 数字 | アルファベット | 日本語     |
;; | 0123 | abcdefghijklmn | こんにちは |

(when is_linux
  (set-face-attribute 'default nil :family "M+ 1mn regular" :height 137 :weight 'regular)
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    (font-spec :family "M+ 1mn"))
  (add-to-list 'face-font-rescale-alist
             '(".*Gen.*" . 1.1)))

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
  :ensure t
  :config
  (volatile-highlights-mode t))

(use-package polymode
  :ensure t
  :config
  (require 'poly-markdown)
  (add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode)))

;; color-themeの設定
;; (require 'color-theme)
;; (color-theme-initialize)
;; (color-theme-andreas)
;; (color-theme-ns-w2)
;; (color-theme-ns)
;; (color-theme-tangotango)
;; (color-theme-tomorrow-night-bright)
;; (color-theme-tomorrow-night)
;; (color-theme-tomorrow-night-eighties)
;; (color-theme-tomorrow)
;; (color-theme-solarized-light)
;; (color-theme-hybrid)
;; (color-theme-mccarthy)

;; after emacs24
(setq custom-theme-directory "~/.emacs.d/themes/")
;; (load-theme 'ns-milk t)
;; (load-theme 'ns-eighties-dark t)
(load-theme 'ns-flat t)


;; モードライン (mode-line-format)での書式記号
;; %b -- print buffer name.
;; %f -- print visited file name.
;; %F -- print frame name.
;; %* -- print %, * or hyphen.
;; %+ -- print *, % or hyphen.
;;       %& is like %*, but ignore read-only-ness.
;;       % means buffer is read-only and * means it is modified.
;;       For a modified read-only buffer, %* gives % and %+ gives *.
;; %s -- print process status.   %l -- print the current line number.
;; %c -- print the current column number (this makes editing slower).
;;       To make the column number update correctly in all cases,`column-number-mode' must be non-nil.
;; %i -- print the size of the buffer.
;; %I -- like %i, but use k, M, G, etc., to abbreviate.
;; %p -- print percent of buffer above top of window, or Top, Bot or All.
;; %P -- print percent of buffer above bottom of window, perhaps plus Top, or print Bottom or All.
;; %n -- print Narrow if appropriate.
;; %t -- visited file is text or binary (if OS supports this distinction).
;; %z -- print mnemonics of keyboard, terminal, and buffer coding systems.
;; %Z -- like %z, but including the end-of-line format.
;; %e -- print error message about full memory.
;; %@ -- print @ or hyphen.  @ means that default-directory is on a remote machine.
;; %[ -- print one [ for each recursive editing level.  %] similar.
;; %% -- print %.
;; %- -- print infinitely many dashes.

;; モードライン
;; (setq-default mode-line-format
;; (list "%*[" 'mode-line-mule-info "] L%l:C%c %P [" `(vc-mode vc-mode) "]   %f   (%m" 'minor-mode-alist ")"))

(use-package powerline
  :ensure t
  :config
  (setq powerline-default-separator 'slant) ;; arrow, slant, chamfer, wave, brace, roundstub, zigzag, butt, rounded, contour, curve
  (defun powerline-my-theme ()
    (interactive)
    (setq-default mode-line-format
                  '("%e"
                    (:eval
                     (let* ((active (powerline-selected-window-active))
                            (mode-line (if active 'mode-line 'mode-line-inactive))
                            (face1 (if active 'powerline-active1 'powerline-inactive1))
                            (face2 (if active 'powerline-active2 'powerline-inactive2))
                            (separator-left (intern (format "powerline-%s-%s"
                                                            (powerline-current-separator)
                                                            (car powerline-default-separator-dir))))
                            (separator-right (intern (format "powerline-%s-%s"
                                                             (powerline-current-separator)
                                                             (cdr powerline-default-separator-dir))))
                            (lhs (list (powerline-raw "%*" face1 'l)
                                       (when powerline-display-mule-info
                                         (powerline-raw mode-line-mule-info face1 'r))
                                       (funcall separator-left face1 face2)
                                       (powerline-major-mode face2 'l)
                                       (when (and (boundp 'which-func-mode) which-func-mode)
                                         (powerline-raw which-func-format face2 'l))
                                       (powerline-raw " " face2 'l)
                                       (powerline-vc face2 'r)
                                       (funcall separator-left face2 mode-line)
                                       (powerline-raw "%b" nil 'l)
                                       ))
                            (rhs (list (unless window-system
                                         (powerline-raw (char-to-string #xe0a1) nil 'l))
                                       (funcall separator-right mode-line face2)
                                       (powerline-raw "%4l" face2 'l)
                                       (powerline-raw ":" face2 'l)
                                       (powerline-raw "%3c" face2 'r)
                                       (powerline-raw "%6p" face2 'r)
                                       (funcall separator-right face2 face1)
                                       (powerline-raw " " face1 'r)
                                       (when powerline-display-buffer-size
                                         (powerline-buffer-size face1 'r)))))
                       (concat (powerline-render lhs)
                               (powerline-fill nil (powerline-width rhs))
                               (powerline-render rhs)))))))
  (powerline-my-theme)
  )

;; タイトルバー
(setq frame-title-format (format "%%f - Emacs@%s" (system-name)))

;; 対応するカッコをハイライト
(show-paren-mode 1)

;; ハイライト
(transient-mark-mode t)

;; カーソル点滅
(blink-cursor-mode t)

;; カーソル行ハイライト
;; (global-hl-line-mode)
(use-package hl-line+
  :ensure t
  ;; :defer t
  :config
  ;; 一定時間後に現在行ハイライト
  (toggle-hl-line-when-idle)
  ;; n 秒後に変更
  (hl-line-when-idle-interval 10))

;; カーソルの形
(set-default 'cursor-type 'box)

;; カーソル位置のフェースを調べる関数
(defun describe-face-at-point ()
  "Return face used at point."
  (interactive)
  (message "%s" (get-char-property (point) 'face)))

;; 折り返しあり
(setq truncate-lines nil)
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
(cond
 (is_emacs23
  (menu-bar-mode nil))
 (is_emacs24
  (tool-bar-mode 0)
  (menu-bar-mode -1)))

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
