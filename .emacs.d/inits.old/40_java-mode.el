;;====================
;; java-mode
;;====================

;; imenu用
(add-hook 'java-mode-hook
          (lambda ()
            (setq imenu-generic-expression
                  '(
                    ("import" "\\(import \\)\\(.*\\)\\(;\\)" 2)
                    ("class" "^[ \\t]*\\(public\\|private\\) +\\(class\\) +\\([^ ]*\\) +\\(.*\\)\\({ *\\)" 3)
                    ("var" "^[ \\t]*\\(public\\|private\\)? +\\(static\\)? +\\([^ ]+\\) +\\([^ ]+\\) += +\\(.*\\)\\(; *\\)" 4)

("method" "[[:alpha:]_][][.[:alnum:]_<> ]+[ 	\n
]+\\([[:alpha:]_][[:alnum:]_]*\\)[ 	\n
]*(\\([ 	\n
]*\\(@[[:alpha:]_][[:alnum:]._]*[ 	\n
]+\\)*\\([[:alpha:]_][][[:alnum:]_.]*\\(<[ 	\n
]*[][.,[:alnum:]_<> 	\n
]*>\\)?\\(\\[\\]\\)?[ 	\n
]+\\)[[:alpha:]_][[:alnum:]_]*[ 	\n
,]*\\)*)[.,[:alnum:] 	\n
]*{" 1)

                    ))))
