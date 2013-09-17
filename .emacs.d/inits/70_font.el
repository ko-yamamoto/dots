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
   (font-spec :family "ricty"))
  ;; ひらがなかたかな
  (set-fontset-font
   nil '(#x3040 . #x30ff)
   (font-spec :family "ricty"))

  (setq face-font-rescale-alist
        '((".Hermit.*" . 1.0)
          (".ricty.*" . 1.2)
          ("-cdac$" . 1.0)))

  )
(when is_win
  (set-default-font "ricty-10.5")
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    '("ricty" . "unicode-bmp"))
  )
(when is_mac
  ;; バラバラに設定する場合
  ;; 英字フォント
  (set-face-attribute 'default nil
                      :family "Hermit"
                      :height 120)
  ;; 漢字フォント
  (set-fontset-font
   nil 'japanese-jisx0208
   (font-spec :family "ricty"))
  ;; ひらがなかたかな
  (set-fontset-font
   nil '(#x3040 . #x30ff)
   (font-spec :family "ricty"))

  (setq face-font-rescale-alist
        '((".Hermit.*" . 1.0)
          (".ricty.*" . 1.2)
          ("-cdac$" . 1.0)))
  )
