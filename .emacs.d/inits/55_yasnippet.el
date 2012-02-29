;;====================
;; yasnippet
;;====================
;; (add-to-list 'load-path "~/.emacs.d/bundle/yasnippet")
(require 'yasnippet)
(yas/global-mode 1)
(yas/load-directory "~/.emacs.d/snippets")

(defun my-yas/prompt (prompt choices &optional display-fn)
  (let* ((names (loop for choice in choices
                      collect (or (and display-fn (funcall display-fn choice))
                                  coice)))
         (selected (anything-other-buffer
                    `(((name . ,(format "%s" prompt))
                       (candidates . names)
                       (action . (("Insert snippet" . (lambda (arg) arg))))))
                    "*anything yas/prompt*")))
    (if selected
        (let ((n (position selected names :test 'equal)))
          (nth n choices))
      (signal 'quit "user quit!"))))
(custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))
(global-set-key (kbd "C-c y") 'yas/insert-snippet)




;; 最近使ったファイルに加えないファイルを正規表現で指定する
(setq recentf-exclude '("/TAGS$" "/var/tmp/"))
(require 'recentf-ext)


;; point-undo 
(require 'point-undo)
(define-key global-map (kbd "<f7>") 'point-undo)
(define-key global-map (kbd "C-q b") 'point-undo)
(define-key global-map (kbd "S-<f7>") 'point-redo)
(define-key global-map (kbd "C-q f") 'point-redo)


;; 最後の変更箇所にジャンプ
(require 'goto-chg)
(define-key global-map (kbd "<f8>") 'goto-last-change)
(define-key global-map (kbd "S-<f8>") 'goto-last-change-reverse)

