(require 'mozc)
;; (set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")
(key-chord-define-global "jk" 'mozc-mode)
