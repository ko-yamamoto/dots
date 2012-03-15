;; 行のどこにカーソルがあっても行全体削除
(defun kill-whole-line (&optional numlines)
  (interactive "p")
  (setq pos (current-column))
  (beginning-of-line)
  (kill-line numlines)
  (move-to-column pos))
(global-set-key (kbd "M-k") 'kill-whole-line)


;; "フォーマット"
(defun indent-buffer ()
  "バッファ全体のインデントを整える"
  (interactive)
  (indent-region (point-min) (point-max)))
(global-set-key (kbd "C-S-f") 'indent-buffer)


;; M-↑などで今の行をコピー
(defun duplicate-line-backward ()
  "Duplicate the current line backward."
  (interactive "*")
  (save-excursion
    (let ((contents
           (buffer-substring
            (line-beginning-position)
            (line-end-position))))
      (beginning-of-line)
      (insert contents ?\n)))
  (previous-line 1))

(defun duplicate-region-backward ()
  "If mark is active duplicates the region backward."
  (interactive "*")
  (if mark-active
      (let* (
             (deactivate-mark nil)
             (start (region-beginning))
             (end (region-end))
             (contents (buffer-substring
                        start
                        end)))
        (save-excursion
          (goto-char start)
          (insert contents))
        (goto-char end)
        (push-mark (+ end (- end start))))
    (error
     "Mark is not active. Region not duplicated.")))

(defun duplicate-line-forward ()
  "Duplicate the current line forward."
  (interactive "*")
  (save-excursion
    (let ((contents (buffer-substring
                     (line-beginning-position)
                     (line-end-position))))
      (end-of-line)
      (insert ?\n contents)))
  (next-line 1))

(defun duplicate-region-forward ()
  "If mark is active duplicates the region forward."
  (interactive "*")
  (if mark-active
      (let* (
             (deactivate-mark nil)
             (start (region-beginning))
             (end (region-end))
             (contents (buffer-substring
                        start
                        end)))
        (save-excursion
          (goto-char end)
          (insert contents))
        (goto-char start)
        (push-mark end)
        (exchange-point-and-mark))
    (error "Mark is not active. Region not duplicated.")))

(global-set-key [M-up]    'duplicate-line-backward)
(global-set-key [M-down]  'duplicate-line-forward)
(global-set-key [M-right] 'duplicate-region-forward)
(global-set-key [M-left]  'duplicate-region-backward)


;; 折り返し表示をトグル
(defun toggle-truncate-lines ()
  "折り返し表示をトグル動作します."
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t))
  (recenter))
(global-set-key (kbd "C-c l") 'toggle-truncate-lines) ; 折り返し表示ON/OFF
(key-chord-define-global "cl" 'toggle-truncate-lines)


;; my window resize
(defun my-window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        action c)
    (catch 'end-flag
      (while t
        (setq action
              (read-key-sequence-vector (format "size[%dx%d]"
                                                (window-width)
                                                (window-height))))
        (setq c (aref action 0))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               ;;               (let ((last-command-char (aref action 0))
               (let ((last-command-event (aref action 0))
                     (command (key-binding action)))
                 (when command
                   (call-interactively command)))
               (message "Quit")
               (throw 'end-flag t)))))))
;; window-resizer C-q C-r (resize)
(global-set-key "\C-q\C-r" 'my-window-resizer)



(defun split-for-twmode ()
  "現在のウィンドウを3等分する関数"
  (interactive)
  (progn
    (split-window-horizontally)
    (other-window 1)
    (split-window-vertically)
    (enlarge-window 7)
    (windmove-left)
    (twit)
    (windmove-right)
    (twit)
    (windmove-down)
    (twittering-replies-timeline)
    (windmove-up)
    ))
(global-set-key "\C-q4" 'split-for-twmode)



;; ちょっとした編集用
(defun open-junk-file ()
  (interactive)
  (let* ((file (expand-file-name
                (format-time-string
                 ;; "%Y/%m/%Y-%m-%d-%H%M%S." (current-time))
                 ;; 月日のディレクトリは作らない
                 "%Y-%m-%d-%H%M%S." (current-time))
                "~/junks/"))
         (dir (file-name-directory file)))
    (make-directory dir t)
    ;; (find-file-other-window (read-string "Junk Code: " file))))
    ;; elscreen するので別ウィンドウで開かないように変更
    (find-file (read-string "Junk Code: " file))))
;; (global-set-key "\C-xj" 'open-junk-file)
(global-set-key (kbd "C-c j") '(lambda () (interactive) (elscreen-create) (open-junk-file)))
