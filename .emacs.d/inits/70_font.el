;;====================
;; フォント
;;====================
;;01234567890123456789
;;あいうえおかきくけこ
(when is_linux
;;  (add-to-list 'default-frame-alist '(font . "A-OTF 新ゴ Pro-11"))

  ;; (set-face-attribute 'default nil
  ;;                     ;; :family "Takaoゴシック"
  ;;                     ;; :family "Inconsolata"
  ;;                     ;; :family "VL ゴシック"
  ;;                     :family "ricty"
  ;;                     ;; :family "MeiryoKe_Console"
  ;;                     :height 115)

  (set-default-font "MeiryoKe_Console-11.0")
  (set-face-font 'variable-pitch "MeiryoKe_Console-11.0")
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    '("MeiryoKe_Console" . "unicode-bmp"))
)
(when is_win
  (set-default-font "ricty-10")
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    '("ricty" . "unicode-bmp"))
)
(when is_mac
  (set-default-font "ricty-14")
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    '("ricty" . "unicode-bmp"))
)


