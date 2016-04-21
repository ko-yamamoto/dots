(use-package twittering-mode
  :ensure t
  :defer t
  :bind (("C-c t t" . twit)
         ("C-c t p" . twittering-update-status-interactive))
  :config
  (setq twittering-use-master-password t)

  ;; 名前用の見た目
  (defface twittering-mode-name-face
    ;; '((t (:foreground "#81a2be"))) nil)
    '((t (:foreground "#81a2be"))) nil)
  ;; つぶやき文字用の見た目
  (defface twittering-mode-text-face
    ;; '((t (:foreground "#444444"))) nil)
    '((t (:foreground "#d3d0c8"))) nil)
  ;;  '((t (:foreground "#ffffff"))) nil)
  ;; 日時用の見た目
  (defface twittering-mode-hide-face
    '((t (:foreground "#f0c674"))) nil)
  ;; in reply to用の見た目
  (defface twittering-mode-reply-face
    '((t (:foreground "#b5bd68"))) nil)
  ;; 区切り用の見た目
  (defface twittering-mode-sepa-face
    ;; '((t (:foreground "#aaaaaa"))) nil)
    '((t (:foreground "#969896"))) nil)

  ;; mode-line に API の残数を表示する
  (setq twittering-display-remaining t)

  ;; icon-mode 有効
  (twittering-icon-mode)

  ;; 表示方法
  (setq twittering-status-format "%i%FACE[twittering-mode-name-face]{%s(%S) %p }%FACE[twittering-mode-reply-face]{%r%R}\n%FACE[twittering-mode-text-face]{%FILL[ ]{%t}}\n%FACE[twittering-mode-hide-face]{%C{%m/%d %H:%M:%S}(%@)}%FACE[twittering-mode-hide-face]{  from %f%L}%FACE[twittering-mode-sepa-face]{\n\n------------------------------------------------------------------------------\n}")

  ;; RT 形式
  (setq twittering-retweet-format " RT @%s: %t")

  ;; 起動時に読み込むタイムライン
  (setq twittering-initial-timeline-spec-string
        '(":replies"
          ":home"))

  (bind-keys :map twittering-mode-map
             ("F" . twittering-favorite)
             ("." . twittering-current-timeline) ; 更新
             ("R" . twittering-reply-to-user)
             ("Q" . twittering-organic-retweet)
             ("T" . twittering-native-retweet)
             ("M" . twittering-direct-message)
             ("N" . twittering-update-status-interactive)
             ("g" . twittering-goto-first-status))

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
  )
