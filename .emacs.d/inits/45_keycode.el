;;====================
;; Keycord
;;====================
;; Keycordの設定
(require 'key-chord)
(key-chord-mode 1)
(setq key-chord-one-keys-delay 0.04)

;; don't hijack input method!
(defadvice toggle-input-method (around toggle-input-method-around activate)
  (let ((input-method-function-save input-method-function))
    ad-do-it
    (setq input-method-function input-method-function-save)))
(key-chord-define-global "YY" 'copy-line)
(key-chord-define-global "VV" 'mark-line)
(key-chord-define-global "DD" 'kill-whole-line)
(key-chord-define-global "mk" 'kill-buffer)
(key-chord-define-global "cv" 'scroll-up)
(key-chord-define-global "vb" 'scroll-down)
(key-chord-define-global "MM" 'occur-by-moccur)
(key-chord-define-global "qi" 'imenu)


(key-chord-define-global "ql" 'windmove-right)
(key-chord-define-global "qh" 'windmove-left)
(key-chord-define-global "qj" 'windmove-down)
(key-chord-define-global "qk" 'windmove-up)
