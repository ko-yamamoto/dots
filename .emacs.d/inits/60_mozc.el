(require 'mozc)
;; (set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")
(key-chord-define-global "jk" 'mozc-mode)
(setq mozc-candidate-style 'overlay)


(setq mozc-color "red")

(defun mozc-change-cursor-color ()
  (if mozc-mode
      (set-buffer-local-cursor-color mozc-color)
    (set-buffer-local-cursor-color nil)))

(add-hook 'input-method-activate-hook
          (lambda () (mozc-change-cursor-color)))

(if (featurep 'key-chord)
    (defadvice toggle-input-method (after my-toggle-input-method activate)
      (mozc-change-cursor-color)))
