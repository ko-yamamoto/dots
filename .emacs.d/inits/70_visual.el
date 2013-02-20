;; ---------------------------------------------------------------------------------
;; Visual Settings
;; ---------------------------------------------------------------------------------

;; タイトルバー
(setq frame-title-format (format "%%b - Emacs@%s" (system-name)))


;; 対応するカッコをハイライト
(show-paren-mode 1)

;; ハイライト
(transient-mark-mode t)

;; 行数表示
;; (global-set-key "\M-n" 'linum-mode)
;; -> yalinum-mode

;; カーソル点滅
(blink-cursor-mode t)



;; カーソル行ハイライト
;; (setq hl-line-face 'underline) ; 下線
(global-hl-line-mode)



;; タブ, 全角スペース, 行末空白表示
(defface my-face-b-1 '((t (:background "gray80"))) nil) ; 全角スペース
(defface my-face-b-2 '((t (:background "gray80"))) nil) ; タブ
;;(defface my-face-u-1 '((t (:background "SteelBlue" :underline t))) nil) ; 行末空白
(defface my-face-u-1 '((t (:background "gray80"))) nil) ; 行末空白
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)

(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-b-2 append)
     ("　" 0 my-face-b-1 append)
     ("[ \t]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;; カーソルの形
;; (add-to-list 'default-frame-alist '(cursor-type 'hollow-rectangle))
;; (add-to-list 'default-frame-alist '(cursor-type '(bar . 3)))
(add-to-list 'default-frame-alist '(cursor-type . (bar . 2)))

;; カーソル位置のフェースを調べる関数
(defun describe-face-at-point ()
  "Return face used at point."
  (interactive)
  (message "%s" (get-char-property (point) 'face)))

;; ツールバーを消す
(cond
 (is_emacs23
  (menu-bar-mode nil))
 (is_emacs24
  (tool-bar-mode 0)
  (menu-bar-mode -1)))

;; スクロールバーを消す
(set-scroll-bar-mode nil)


(require 'cl)  ; loop, delete-duplicates

(defun anything-font-families ()
  "Preconfigured `anything' for font family."
  (interactive)
  (flet ((anything-mp-highlight-match () nil))
    (anything-other-buffer
     '(anything-c-source-font-families)
     "*anything font families*")))

(defun anything-font-families-create-buffer ()
  (with-current-buffer
      (get-buffer-create "*Fonts*")
    (loop for family in (sort (delete-duplicates (font-family-list)) 'string<)
          do (insert
              (propertize (concat family "\n")
                          'font-lock-face
                          (list :family family :height 2.0 :weight 'bold))))
    (font-lock-mode 1)))

(defvar anything-c-source-font-families
  '((name . "Fonts")
    (init lambda ()
          (unless (anything-candidate-buffer)
            (save-window-excursion
              (anything-font-families-create-buffer))
            (anything-candidate-buffer
             (get-buffer "*Fonts*"))))
    (candidates-in-buffer)
    (get-line . buffer-substring)
    (action
     ("Copy Name" lambda
      (candidate)
      (kill-new candidate))
     ("Insert Name" lambda
      (candidate)
      (with-current-buffer anything-current-buffer
        (insert candidate))))))
