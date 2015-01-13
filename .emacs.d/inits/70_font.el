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
  ;; バラバラに設定する場合
  ;; 英字フォント
  (set-face-attribute 'default nil
                      :family "ricty"
                      :height 150)
  ;; 漢字フォント
  (set-fontset-font
   nil 'japanese-jisx0208
   (font-spec :family "07YasashisaGothic"))
  ;; ひらがなかたかな
  (set-fontset-font
   nil '(#x3040 . #x30ff)
   (font-spec :family "07YasashisaGothic"))

  (setq face-font-rescale-alist
        '((".Hermit.*" . 1.0)
          (".ricty.*" . 1.2)
          (".Koruri.*" . 1.2)
          ("-cdac$" . 1.0)))
  )
