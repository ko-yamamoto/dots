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
                    :default  '(progn
                                 ;; 無駄なスペースを削除
                                 (delete-trailing-whitespace)
                                 (case major-mode
                                   (org-mode (org-return-indent))
                                   (t        (newline-and-indent))))
                    ;; 行末で C-u+C-j で fill-region を実行する
                    :C-u&eolp '(fill-region (point-at-bol) (point-at-eol))
                    :region   'query-replace-regexp)))

(global-set-key (kbd "C-;")
                '(lambda ()
                   (interactive)
                   (mykie
                    :default            'helm-my
                    :region             'helm-occur
                    :region-handle-flag 'copy)))

(global-set-key (kbd "o")
                '(lambda ()
                   (interactive)
                   (mykie
                    :default 'self-insert-command
                    :region 'occur-by-moccur
                    :region&C-u 'moccur-grep-find
                    :region-handle-flag 'copy)))

(global-set-key (kbd "r")
                '(lambda ()
                   (interactive)
                   (mykie
                    :default 'self-insert-command
                    :region '(progn
                               (deactivate-mark)
                               (anzu-query-replace))
                    :region&C-u 'anzu-query-replace
                    :region-handle-flag 'copy)))
