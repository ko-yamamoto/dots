;;====================
;; ddskk
;;====================
(add-to-list 'load-path "~/.emacs.d/skk")

(require 'skk-autoloads)
(global-set-key (kbd "C-q s s") 'skk-mode)
(key-chord-define-global "jk" 'skk-mode)
;; (when is_win
;;   ;; Windows の場合、変換/無変換キーでオンオフする
;;   (global-set-key [convert] 'skk-mode)
;;   (global-set-key [non-convert] 'skk-mode)
;; )
(global-set-key (kbd "C-q s a") 'skk-auto-fill-mode)
(global-set-key (kbd "C-q s t") 'skk-tutorial)

;; ddskk 起動時のみ, インクリメンタルサーチを使用
;;; Isearch setting.
(add-hook 'isearch-mode-hook
          #'(lambda ()
              (when (and (boundp 'skk-mode)
                         skk-mode
                         skk-isearch-mode-enable)
                (skk-isearch-mode-setup))))
(add-hook 'isearch-mode-end-hook
          #'(lambda ()
              (when (and (featurep 'skk-isearch)
                         skk-isearch-mode-enable)
                (skk-isearch-mode-cleanup))))

;; 文脈に応じてSKKオンオフ
;; (add-hook 'skk-load-hook
;; 	  (lambda ()
;; 	    (require 'context-skk)))

;; Google サジェストする
(require 'skk-search-web)
