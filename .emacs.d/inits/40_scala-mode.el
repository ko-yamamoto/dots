;;====================
;; scala-mode
;;====================

;; see el-get

;; ensime ;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/elisp/ensime_2.10.0-RC3-0.9.8.2/elisp/")
(require 'ensime)

;; ensime 同梱の auto-complete を使おうとするのを止める
(setq ensime-ac-override-settings nil)

(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; imenu用
(add-hook 'scala-mode-hook
          (lambda ()
            ;; (scala-electric-mode) ;; not compatible with scala-mode2
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
