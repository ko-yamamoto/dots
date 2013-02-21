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
  ;; (set-default-font "VL ゴシック-10.0")
  ;; (set-face-font 'variable-pitch "VL ゴシック-10.0")
  ;; (set-fontset-font (frame-parameter nil 'font)
  ;;                   'japanese-jisx0208
  ;;                   '("VL ゴシック" . "unicode-bmp"))
  ;; (set-default-font "ricty-9")
  (set-default-font "ricty:pixelsize=12:spacing=0")
  ;; (set-default-font "VL ゴシック-9")
  ;; (set-face-font 'variable-pitch "ricty-9")
  ;; (set-face-font 'variable-pitch "VL ゴシック-9")
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    '("ricty" . "unicode-bmp"))
                    ;; '("VL ゴシック" . "unicode-bmp"))

)
(when is_win
  (set-default-font "ricty-10.5")
  ;; (set-default-font "MeiryoKe_Console-10.5")
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    '("ricty" . "unicode-bmp"))
                    ;; '("MeiryoKe_Console" . "unicode-bmp"))

)
(when is_mac
  (set-frame-font "M+ 1mn medium:pixelsize=12:spacing=0:slant=1")
  (progn
    (set-face-font 'default "M+ 1mn bold:pixelsize=12:spacing=0:slant=1")
    (set-face-font 'bold "M+ 1mn bold:pixelsize=12:spacing=0:slant=1")
    ;; (set-face-font 'italic "M+ 1mn bold:pixelsize=12:spacing=0:slant=1")
    ;; (set-face-font 'bold-italic "M+ 1mn bold:pixelsize=12:spacing=0:slant=1")
    )
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    '("M+ 1mn medium" . "unicode-bmp"))

  ;; バラバラに設定する場合
  ;; ;; 英字フォントk
  ;; (set-face-attribute 'default nil
  ;;                     :family "ricty"
  ;;                     :height 140)
  ;; ;; 漢字フォント
  ;; (set-fontset-font
  ;;  nil 'japanese-jisx0208
  ;;  (font-spec :family "NfMotoyaAporo"))
  ;; ;; ひらがなかたかな
  ;; (set-fontset-font
  ;;  nil '(#x3040 . #x30ff)
  ;;  (font-spec :family "NfMotoyaAporo"))

  ;; (setq face-font-rescale-alist
  ;;       '((".ricty.*" . 1.0)
  ;;         (".NfMotoyaAporo.*" . 1.0)
  ;;         ("-cdac$" . 1.0)))
)
