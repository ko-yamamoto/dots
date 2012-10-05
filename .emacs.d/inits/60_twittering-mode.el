;;====================
;; twittering-mode
;;====================
;; (el-get:use twittering-mode)
(require 'twittering-mode)
;; (autoload 'twittering-numbering "twittering-numbering" t)
;; (add-hook 'twittering-mode-hook 'twittering-numbering)
(setq twittering-use-master-password t)


;; (setq background "#1d1f21"
;;       current-line "#282a2e"
;;       selection "#373b41"
;;       foreground "#c5c8c6"
;;       comment "#969896"
;;       cursor "#aeafad"
;;       red "#cc6666"
;;       orange "#de935f"
;;       yellow "#f0c674"
;;       green "#b5bd68"
;;       aqua "#8abeb7"
;;       blue "#81a2be"
;;       purple "#b294bb")
;; 名前用の見た目
(defface twittering-mode-name-face
  ;; '((t (:foreground "#81a2be"))) nil)
  '((t (:foreground "#f0c674"))) nil)
;; つぶやき文字用の見た目
(defface twittering-mode-text-face
  ;; '((t (:foreground "#444444"))) nil)
  '((t (:foreground "#81a2be"))) nil)
;;  '((t (:foreground "#ffffff"))) nil)
;; 日時用の見た目
(defface twittering-mode-hide-face
  '((t (:foreground "#969896"))) nil)
;; in reply to用の見た目
(defface twittering-mode-reply-face
  '((t (:foreground "#b5bd68"))) nil)
;; 区切り用の見た目
(defface twittering-mode-sepa-face
  ;; '((t (:foreground "#aaaaaa"))) nil)
  '((t (:foreground "#363836"))) nil)


;; mode-line に API の残数を表示する
(setq twittering-display-remaining t)

;; icon-mode 有効
(twittering-icon-mode)

;; 表示方法
(setq twittering-status-format "%i%FACE[twittering-mode-name-face]{%s(%S) %p }%FACE[twittering-mode-reply-face]{%r%R}\n%FACE[twittering-mode-text-face]{%FILL[ ]{%t}}\n%FACE[twittering-mode-hide-face]{%C{%m/%d %H:%M:%S}(%@)}%FACE[twittering-mode-hide-face]{  from %f%L}%FACE[twittering-mode-sepa-face]{\n\n------------------------------------------------------------------------------------\n}")

;; RT 形式
(setq twittering-retweet-format " RT @%s: %t")

;; 起動時に読み込むタイムライン
(setq twittering-initial-timeline-spec-string
      '(":replies"
        ":home"))

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



(global-set-key "\C-qtt" 'twit)
(global-set-key (kbd "C-q t p") 'twittering-update-status-interactive)


;; Format string for rendering statuses.
;; Ex. \"%i %s,  %@:\\n%FILL{  %T // from %f%L%r%R}\n \"

;; Items:
;;  %s - screen_name
;;  %S - name
;;  %i - profile_image
;;  %d - description
;;  %l - location
;;  %L - \" [location]\"
;;  %r - \" sent to user\" (use on direct_messages{,_sent})
;;  %r - \" in reply to user\" (use on other standard timeline)
;;  %R - \" (retweeted by user)\"
;;  %RT{...} - strings rendered only when the tweet is a retweet.
;;             The braced strings are rendered with the information of the
;;             retweet itself instead of that of the retweeted original tweet.
;;             For example, %s for a retweet means who posted the original
;;             tweet, but %RT{%s} means who retweeted it.
;;  %u - url
;;  %j - user.id
;;  %p - protected?
;;  %c - created_at (raw UTC string)
;;  %C{time-format-str} - created_at (formatted with time-format-str)
;;  %@ - X seconds ago
;;  %T - raw text
;;  %t - text filled as one paragraph
;;  %' - truncated
;;  %FACE[face-name]{...} - strings decorated with the specified face.
;;  %FILL[prefix]{...} - strings filled as a paragraph. The prefix is optional.
;;                       You can use any other specifiers in braces.
;;  %FOLD[prefix]{...} - strings folded within the frame width.
;;                       The prefix is optional. This keeps newlines and does not
;;                       squeeze a series of white spaces.
;;                       You can use any other specifiers in braces.
;;  %f - source
;;  %# - id
