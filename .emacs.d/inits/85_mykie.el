(require 'mykie)


(global-set-key (kbd "C-a")
                '(lambda ()
                   (interactive)
                   (mykie
                    :default     'my-toggle-beginning-of-line-and-sentence
                    :C-u         'mark-whole-buffer)))

(global-set-key (kbd "C-j")
                '(lambda ()
                   (interactive)
                   (mykie
                    :default            '(progn
                                           ;; 無駄なスペースを削除
                                           (delete-trailing-whitespace)
                                           (case major-mode
                                             (org-mode (org-return-indent))
                                             (t        (newline-and-indent))))
                    ;; 行末で C-u+C-j で fill-region を実行する
                    :C-u&eolp           '(fill-region (point-at-bol) (point-at-eol))
                    :region             'query-replace-regexp)))
