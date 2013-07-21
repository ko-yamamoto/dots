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
    (find-file (read-string "Junk Code: " file))))
(global-set-key "\C-cj" 'open-junk-file)



;; ;; 'o' 次の行に挿入
;; (defun edit-next-line ()
;;   (interactive)
;;   (end-of-line)
;;   (newline-and-indent))
;; ;; 'O' 前の行に挿入
;; (defun edit-previous-line ()
;;   (interactive)
;;   (forward-line -1)
;;   (if (not (= (current-line) 1))
;;       (end-of-line))
;;   (newline-and-indent))
;; (key-chord-define-global "vo" 'edit-next-line)

;; ;; 'f' 後方の入力した文字の上に移動
;; (defun forward-match-char (n)
;;   (interactive "p")
;;   (let ((c (read-char)))
;;     (dotimes (i n)
;;       (forward-char)
;;       (skip-chars-forward (format "^%s" (char-to-string c))))))
;; ;; 'F' 前方の入力した文字の上に移動
;; (defun backward-match-char (n)
;;   (interactive "p")
;;   (let ((c (read-char)))
;;     (dotimes (i n)
;;       (skip-chars-backward (format "^%s" (char-to-string c)))
;;       (backward-char))))
;; (global-set-key (kbd "M-l") 'forward-match-char)
;; (global-set-key (kbd "M-L") 'backward-match-char)
;; (key-chord-define-global "vf" 'forward-match-char)


(defun window-toggle-division ()
  "ウィンドウ 2 分割時に、縦分割<->横分割"
  (interactive)
  (unless (= (count-windows 1) 2)
    (error "ウィンドウが 2 分割されていません。"))
  (let ((before-height)
        (other-buf (window-buffer (next-window))))
    (setq before-height (window-height))
    (delete-other-windows)
    (if (= (window-height) before-height)
        (split-window-vertically)
      (split-window-horizontally))
    (other-window 1)
    (switch-to-buffer other-buf)
    (other-window -1)))
(global-set-key (kbd "C-q 0") 'window-toggle-division)


(defun find-file-other-exist-window (filename)
  "ウィンドウ 2 分割時に、もう片方のウィンドウでファイルを開く"
  (interactive)
  (cond ((one-window-p)
         ;; ウィンドウが1つの時は新しく開いたウィンドウで編集へ
         (my/split-v-gration-windows)
         (other-window 1)
         (find-file filename))
        ((= (count-windows 1) 2)
         ;; ウィンドウが2つの時は既存のもう片方のウィンドウで編集へ
         (other-window 1)
         (find-file filename))
        ((> (count-windows 1) 2)
         ;; ウィンドウが3つ以上の時はエラー
         (error "ウィンドウが 2 分割されていません。"))))

(defun my/split-v-gration-windows ()
  ;; 丁度良くウィンドウを分割
  (interactive)
  ;; (progn
    (let* ((ration
            (if (> (frame-width) 220)
                0.375 ;; 画面が広い場合は黄金比
              0.3)))
    (split-window (selected-window) (round (* ration (window-width))) t)))
(global-set-key (kbd "C-q 7") 'my/split-v-gration-windows)


(defun my/buffer-kill-and-delete-window ()
  (interactive)
  (kill-buffer)
  (delete-window))



(defun my-comment-out-this-line ()
  (interactive)
  (let* ((bol (progn (beginning-of-line) (point)))
         (eol (progn (end-of-line) (point))))
    (comment-region bol eol)
    (back-to-indentation)
    ))
;; (global-set-key (kbd "M-;") 'my-comment-out-this-line)


(defun my-toggle-beginning-of-line-and-sentence ()
  "文頭と行頭を移動"
  (interactive)
  (if (/= (line-beginning-position) (point))
      (beginning-of-line)
    (beginning-of-line-text))
  )
(global-set-key (kbd "C-a") 'my-toggle-beginning-of-line-and-sentence)
