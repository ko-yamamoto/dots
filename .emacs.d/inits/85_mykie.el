(require 'mykie)
(setq mykie:use-major-mode-key-override t)
(mykie:initialize)

(mykie:global-set-key "C-a"
  :default     my-toggle-beginning-of-line-and-sentence
  :C-u         mark-whole-buffer)

(mykie:global-set-key "C-j"
  :default  (progn
              ;; 無駄なスペースを削除
              (delete-trailing-whitespace)
              (case major-mode
                (org-mode (org-return-indent))
                (t        (newline-and-indent))))
  ;; 行末で C-u+C-j で fill-region を実行する
  :C-u&eolp (fill-region (point-at-bol) (point-at-eol))
  :region   query-replace-regexp)

(mykie:global-set-key "C-;"
  :default            helm-my
  :region             helm-occur
  :region-handle-flag copy)

(mykie:global-set-key "o"
  :default self-insert-command
  :region occur-by-moccur
  :region&C-u moccur-grep-find
  :region-handle-flag copy)

;; (mykie:global-set-key "r"
;;   :default self-insert-command
;;   :region (progn
;;             (beginning-of-buffer)
;;             ;; (deactivate-mark)
;;             ;; (anzu-query-replace (substring-no-properties (car kill-ring)))
;;             (anzu-query-replace)
;;             )
;;   :region&C-u anzu-query-replace
;;   :region-handle-flag copy)
