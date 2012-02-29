;;====================
;; twittering-mode
;;====================
;; (el-get:use twittering-mode)
(require 'twittering-mode)
;; (autoload 'twittering-numbering "twittering-numbering" t)
;; (add-hook 'twittering-mode-hook 'twittering-numbering)
(setq twittering-use-master-password t)
(setq twittering-status-format "%i%S(%s) %p %R \n%C{%m/%d %H:%M:%S}(%@)  \n\n  %t \n\nfrom %f%L\n\n")

(setq twittering-retweet-format " RT @%s: %t")

;; 起動時に読み込むタイムライン
(setq twittering-initial-timeline-spec-string
      '(":replies"
        ":home"))

(global-set-key (kbd "C-q t p") 'twittering-update-status-interactive)
(add-hook 'twittering-mode-hook
          (lambda ()
            (mapc (lambda (pair)
                    (let ((key (car pair))
                          (func (cdr pair)))
                      (define-key twittering-mode-map
                        (read-kbd-macro key) func)))
                  '(("F" . twittering-favorite)
                    ("R" . twittering-reply-to-user)
                    ("Q" . twittering-organic-retweet)
                    ("T" . twittering-native-retweet)
                    ("M" . twittering-direct-message)
                    ("N" . twittering-update-status-interactive)
                    ("." . twittering-current-timeline) ; 更新
                    ))))

