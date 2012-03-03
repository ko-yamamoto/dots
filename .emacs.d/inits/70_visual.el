;; ---------------------------------------------------------------------------------
;; Visual Settings
;; ---------------------------------------------------------------------------------

;; タイトルバー
(setq frame-title-format (format "%%f - Emacs@%s" (system-name)))


;; 対応するカッコをハイライト
(show-paren-mode 1)

;; ハイライト
(transient-mark-mode t)

;; 行数表示
(global-set-key "\M-n" 'linum-mode)

;; カーソル点滅
(blink-cursor-mode t)



;; カーソル行ハイライト
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "grey5"))
    (((class color)
      (background light))
;;     (:background "lemon chiffon"))
     (:background "#e8ff9e"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
;; (setq hl-line-face 'underline) ; 下線
(global-hl-line-mode)


;; 1画面スクロールで前の表示を何行分残すか
(setq next-screen-context-lines 5)


;; タブ, 全角スペース, 行末空白表示
(defface my-face-b-1 '((t (:background "gray25"))) nil) ; 全角スペース
(defface my-face-b-2 '((t (:background "gray25"))) nil) ; タブ
;;(defface my-face-u-1 '((t (:background "SteelBlue" :underline t))) nil) ; 行末空白
(defface my-face-u-1 '((t (:background "gray20"))) nil) ; 行末空白
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
(add-to-list 'default-frame-alist '(cursor-type 'hollow-rectangle))
;; カーソルの色
(add-to-list 'default-frame-alist '(cursor-color . "#ffcc66"))

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
  (tool-bar-mode 0)))



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

