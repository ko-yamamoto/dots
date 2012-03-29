;;====================
;; scala-mode
;;====================
(add-to-list 'load-path "~/.emacs.d/snippets/scala-mode")
(require 'scala-mode-auto)
(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))
(require 'scala-mode-feature-electric)
(add-hook 'scala-mode-hook
          (lambda ()
            (scala-electric-mode)
            (define-key scala-mode-map my-shell-pop-key 'shell-pop)
            (define-key scala-mode-map [(C-tab)] 'elscreen-next) ; ブラウザみたいに
            ))

;; ensime
;; (add-to-list 'load-path "~/.emacs.d/ensime/elisp/")
;; (require 'ensime)
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)


;; imenu用
(add-hook 'scala-mode-hook
          (lambda ()
            (scala-electric-mode)
            (setq imenu-generic-expression
                  '(
                    ("var" "\\(var +\\)\\([^(): ]+\\)" 2)
                    ("val" "\\(val +\\)\\([^(): ]+\\)" 2)
                    ("override def" "^[ \\t]*\\(override\\) +\\(def +\\)\\([^(): ]+\\)" 3)
                    ("implicit def" "^[ \\t]*\\(implicit\\) +\\(def +\\)\\([^(): ]+\\)" 3)
                    ("def" "^[ \\t]*\\(def +\\)\\([^(): ]+\\)" 2)
                    ("trait" "\\(trait +\\)\\([^(): ]+\\)" 2)
                    ("class" "^[ \\t]*\\(class +\\)\\([^(): ]+\\)" 2)
                    ("case class" "^[ \\t]*\\(case class +\\)\\([^(): ]+\\)" 2)
                    ("object" "\\(object +\\)\\([^(): ]+\\)" 2)
                    ))))


;; インデント修正
(defadvice scala-block-indentation (around improve-indentation-after-brace activate)
  (if (eq (char-before) ?\{)
      (setq ad-return-value (+ (current-indentation) scala-mode-indent:step))
    ad-do-it))
(defun scala-newline-and-indent ()
  (interactive)
  (delete-horizontal-space)
  (let ((last-command nil))
    (newline-and-indent))
  (when (scala-in-multi-line-comment-p)
    (insert "* ")))
(add-hook 'scala-mode-hook
          (lambda ()
            (define-key scala-mode-map (kbd "RET") 'scala-newline-and-indent)))
