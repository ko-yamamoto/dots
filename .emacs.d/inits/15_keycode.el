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
(key-chord-define-global "mk" 'kill-buffer)
(key-chord-define-global "MK" 'my/buffer-kill-and-delete-window)
;; (key-chord-define-global ".." 'set-mark-command)
