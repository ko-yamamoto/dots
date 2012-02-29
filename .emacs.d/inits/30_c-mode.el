;;====================
;; c-mode(c++)
;;====================

(add-hook 'c-mode-common-hook
          '(lambda ()
             ;; センテンスの終了である ';' を入力したら、自動改行+インデント
             (c-toggle-auto-hungry-state 1)
             ;; RET キーで自動改行+インデント
             (define-key c-mode-base-map "\C-m" 'newline-and-indent)
             ))


;; C-c c で compile コマンドを呼び出す
(define-key mode-specific-map "c" 'compile)


