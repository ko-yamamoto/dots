;; タイトルバー
(setq frame-title-format (format "%%b - Emacs@%s" (system-name)))

;; 対応するカッコをハイライト
(show-paren-mode 1)

;; ハイライト
(transient-mark-mode t)

;; カーソル点滅
(blink-cursor-mode t)

;; カーソル行ハイライト
;; (setq hl-line-face 'underline) ; 下線
(global-hl-line-mode)

;; カーソルの形
(set-default 'cursor-type '(hbar . 5))

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
;; (global-set-key "\M-n" 'linum-mode)

(use-package yalinum
  :ensure t
  :bind (("M-n" . yalinum-mode)))


;; ツールバーを消す
(cond
 (is_emacs23
  (menu-bar-mode nil))
 (is_emacs24
  (tool-bar-mode 0)
  (menu-bar-mode -1)))

;; スクロールバーを消す
(set-scroll-bar-mode nil)

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
(setq custom-theme-directory "~/.emacs.d/elisp/themes/")
(load-theme 'ns-milk t)

;; タブ, 全角スペース, 行末空白表示
(defface my-face-b-1 '((t (:background "#ffe174" :underline t))) nil) ; 全角スペース
(defface my-face-b-2 '((t (:background "#ffe174" :underline t))) nil) ; タブ
(defface my-face-u-1 '((t (:background "#ffe174" :underline t))) nil) ; 行末空白
(defface my-face-u-1 '((t (:background "#ffe174" :underline t))) nil) ; 行末空白
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
(add-to-list 'default-frame-alist '(alpha . (0.9 0.9)))

;; キーワードのカラー表示を有効化
(global-font-lock-mode t)

;; 選択範囲をハイライト
(setq-default transient-mark-mode t)

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

  ;; バラバラに設定する場合
  ;; 英字フォント
  (set-face-attribute 'default nil
                      :family "Hermit"
                      :height 90)
  ;; 漢字フォント
  (set-fontset-font
   nil 'japanese-jisx0208
   ;; (font-spec :family "ricty"))
   (font-spec :family "07YasashisaGothic"))
  ;; ひらがなかたかな
  (set-fontset-font
   nil '(#x3040 . #x30ff)
   ;; (font-spec :family "ricty"))
   (font-spec :family "07YasashisaGothic"))

  (setq face-font-rescale-alist
        '((".*Hermit.*" . 1.0)
          (".*ricty.*" . 1.2)
          (".*やさしさ.*" . 1.2)
          ("-cdac$" . 1.0)))

  )
(when is_win
  ;; バラバラに設定する場合
  ;; 英字フォント
  (set-face-attribute 'default nil
                      :family "M+ 1m regular"
                      :height 100)
  ;; 漢字フォント
  (set-fontset-font
   nil 'japanese-jisx0208
   (font-spec :family "M+ 1m"))
  ;; ひらがなかたかな
  (set-fontset-font
   nil '(#x3040 . #x30ff)
   (font-spec :family "M+ 1m"))

  (setq face-font-rescale-alist
        '((".*Hermit.*" . 1.0)
          (".*ricty.*" . 1.2)
          (".*やさしさ.*" . 1.2)
          (".*Noto.*" . 1.1)
          ("-cdac$" . 1.0)))
  )
(when is_mac
  (set-face-attribute 'default nil :family "M+ 1mn" :height 160 :weight 'light)
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    (font-spec :family "M+ 1mn"))
  (add-to-list 'face-font-rescale-alist
               '(".*M+ 1mn.*" . 1.0)))


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
(setq-default mode-line-format
              (list "%*[" 'mode-line-mule-info "] L%l:C%c %P [" `(vc-mode vc-mode) "]   %f   (%m" 'minor-mode-alist ")"))

;; -> el-get の powerline で設定

;; git ブランチ名を表示
;; (vc-mode vc-mode) が置き換わる
(require 'modeline-git-branch)
(modeline-git-branch-mode 1)

;; モード名をエイリアス
(defvar mode-line-cleaner-alist
  '( ;; For minor-mode, first char is 'space'
    (abbrev-mode . "")
    (guide-key-mode . "")
    (undo-tree-mode . "")
    (wrap-region-mode . "")
    (smooth-scroll-mode . "")
    (helm-mode . "")
    (back-button-mode . "")
    ;; Major modes
    ;; (lisp-interaction-mode . "Li")
    ;; (python-mode . "Py")
    ;; (ruby-mode   . "Rb")
    ;; (emacs-lisp-mode . "El")
    ;; (lisp-mode . "Li")
    ;; (markdown-mode . "Md")
    ))

(defun clean-mode-line ()
  (interactive)
  (loop for (mode . mode-str) in mode-line-cleaner-alist
        do
        (let ((old-mode-str (cdr (assq mode minor-mode-alist))))
          (when old-mode-str
            (setcar old-mode-str mode-str))
          ;; major mode
          (when (eq mode major-mode)
            (setq mode-name mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)
