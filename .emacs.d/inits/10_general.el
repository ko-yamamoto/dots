;; ---------------------------------------------------------------------------------
;; General Settings
;; ---------------------------------------------------------------------------------


;; マウスの右クリックの割り当て(押しながらの操作)をはずす
(if window-system (progn
        (global-unset-key [down-mouse-3])
;; マウスの右クリックメニューを使えるようにする
(defun bingalls-edit-menu (event)  (interactive "e")
    (popup-menu menu-bar-edit-menu))
    (global-set-key [mouse-3] 'bingalls-edit-menu)))

;; C-hをヘルプから外すための設定
(load "term/bobcat")
(when (fboundp 'terminal-init-bobcat) (terminal-init-bobcat))

;; 共通ロードパスを通す OSごと設定は下の方で
(setq load-path (cons "~/.emacs.d/elisp" load-path))
;; emacs.d/elisp以下を再帰的にload-pathへ追加
(let ((default-directory (expand-file-name "~/.emacs.d/elisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

;; package.elでインストールしたelispをload-pathへ追加
(let ((default-directory (expand-file-name "~/.emacs.d/elpa")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))



;; language & code
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)


;; beepを消す
(setq visible-bell t)
(setq ring-bell-function 'ignore)


;; 起動時のメッセージを非表示
(setq inhibit-startup-message t)


;; ヘルプコマンドをC-^に割り当てる
(global-set-key "\C-^" 'help-command)


;; "yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)


;; 現在位置のファイルを開く
(ffap-bindings)


;; タブは4
(setq-default tab-width 4)
(setq default-tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                        64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
;; タブはスペースで
(setq-default tab-width 4 indent-tabs-mode nil)

;; バッファ一覧をまともに
(global-set-key "\C-x\C-b" 'bs-show)

;; 最近のファイル500個を保存する
(setq recentf-max-saved-items 500)
(setq recentf-max-menu-items 30)


;; 行のどこにカーソルがあっても行全体削除
(defun kill-whole-line (&optional numlines)
  (interactive "p")
  (setq pos (current-column))
  (beginning-of-line)
  (kill-line numlines)
  (move-to-column pos))
(global-set-key (kbd "M-k") 'kill-whole-line)


;; "フォーマット"
(defun format-line-indent ()
  "バッファ全体のインデントを整える"
  (interactive)
  (indent-region (point-min) (point-max)))
(global-set-key (kbd "C-S-f") 'kill-whole-line)







                                        ; ごみ箱を有効
(setq delete-by-moving-to-trash t)

;; バックアップファイルを作らない
(setq backup-inhibited t)

;; オートセーブしない
(setq make-backup-files nil)

;; 保存時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;; バックアップファイルの場所
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

;; 前回編集場所を記憶
(load "saveplace")
(setq-default save-place t)


;; 起動画面を表示しない
(setq inhibit-startup-message t)


;; Emacs serverを起動
(server-start)
(defun iconify-emacs-when-server-is-done ()
  (unless server-clients (iconify-frame)))


;; ターミナルに戻る
(add-hook 'server-done-hook 'iconify-emacs-when-server-is-done)
(global-set-key (kbd "C-x c") 'server-edit)


;; 置換(M-%)キーバインドを(C-c r)にも
(global-set-key (kbd "C-c r") 'query-replace)


;; オートコンパイル
;;(require 'auto-async-byte-compile)
;; オートコンパイル無効にする正規表現
;;(setq auto-async-byte-compile-exclude-file-regexp "/junk/")
;;(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)


;; 1画面戻る(M-v)を"Ctr-Shift-v"にも
(global-set-key (kbd "C-S-v") 'scroll-down)

;; リージョン選択した状態でisearchすると選択後を検索
(defadvice isearch-mode (around isearch-mode-default-string (forward &optional regexp op-fun recursive-edit word-p) activate)
  (if (and transient-mark-mode mark-active (not (eq (mark) (point))))
      (progn
        (isearch-update-ring (buffer-substring-no-properties (mark) (point)))
        (deactivate-mark)
        ad-do-it
        (if (not forward)
            (isearch-repeat-backward)
          (goto-char (mark))
          (isearch-repeat-forward)))
    ad-do-it))



;; ビューモード
;; (setq view-read-only t)
;; (defvar pager-keybind
;;       `( ;; vi-like
;;         ("h" . backward-word)
;;         ("l" . forward-word)
;;         ("j" . next-line)
;;         ("k" . previous-line)
;;         (";" . gene-word)
;;         ("b" . scroll-down)
;;         (" " . scroll-up)
;;         ;; w3m-like
;;         ("m" . gene-word)
;;         ("i" . win-delete-current-window-and-squeeze)
;;         ("w" . forward-word)
;;         ("e" . backward-word)
;;         ("(" . point-undo)
;;         (")" . point-redo)
;;         ("J" . ,(lambda () (interactive) (scroll-up 1)))
;;         ("K" . ,(lambda () (interactive) (scroll-down 1)))
;;         ;; bm-easy
;;         ("." . bm-toggle)
;;         ("[" . bm-previous)
;;         ("]" . bm-next)
;;         ;; langhelp-like
;;         ("c" . scroll-other-window-down)
;;         ("v" . scroll-other-window)
;;         ))

;; (defun define-many-keys (keymap key-table &optional includes)
;;   (let (key cmd)
;;     (dolist (key-cmd key-table)
;;       (setq key (car key-cmd)
;;             cmd (cdr key-cmd))
;;       (if (or (not includes) (member key includes))
;;         (define-key keymap key cmd))))
;;   keymap)


;; (defun view-mode-hook0 ()
;;   (define-many-keys view-mode-map pager-keybind)
;;   (hl-line-mode 1)
;;   (define-key view-mode-map " " 'scroll-up))
;; (add-hook 'view-mode-hook 'view-mode-hook0)


;; 書き込み不能なファイルはview-modeで開くように
;; (defadvice find-file
;;   (around find-file-switch-to-view-file (file &optional wild) activate)
;;   (if (and (not (file-writable-p file))
;;            (not (file-directory-p file)))
;;       (view-file file)
;;     ad-do-it))

;; 書き込み不能な場合はview-modeを抜けないように
;; (defvar view-mode-force-exit nil)
;; (defmacro do-not-exit-view-mode-unless-writable-advice (f)
;;   `(defadvice ,f (around do-not-exit-view-mode-unless-writable activate)
;;      (if (and (buffer-file-name)
;;               (not view-mode-force-exit)
;;               (not (file-writable-p (buffer-file-name))))
;;          (message "File is unwritable, so stay in view-mode.")
;;        ad-do-it)))

;; (do-not-exit-view-mode-unless-writable-advice view-mode-exit)
;; (do-not-exit-view-mode-unless-writable-advice view-mode-disable)


;; M-Yで1行コピー
(global-set-key (kbd "M-Y") 'copy-line)


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
(global-set-key (kbd "C-c C-l") 'toggle-truncate-lines) ; 折り返し表示ON/OFF


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


;; C-q -> pre-fix key
(define-key global-map "\C-q" (make-sparse-keymap))

;; quoted-insert -> C-q C-q
(global-set-key "\C-q\C-q" 'quoted-insert)

;; window-resizer C-q C-r (resize)
(global-set-key "\C-q\C-r" 'my-window-resizer)

;; window move
(global-set-key "\C-ql" 'windmove-right)
(global-set-key "\C-qh" 'windmove-left)
(global-set-key "\C-qj" 'windmove-down)
(global-set-key "\C-qk" 'windmove-up)

;; window split
(global-set-key "\C-q1" 'delete-other-windows)
(global-set-key "\C-q2" 'split-window-vertically)
(global-set-key "\C-q3" 'split-window-horizontally)
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

(global-set-key "\C-qtt" 'twit)



;; 自動でchmod+x
(defun make-file-executable ()
  "Make the file of this buffer executable, when it is a script source."
  (save-restriction
    (widen)
    (if (string= "#!" (buffer-substring-no-properties 1 (min 3 (point-max))))
        (let ((name (buffer-file-name)))
          (or (equal ?. (string-to-char (file-name-nondirectory name)))
              (let ((mode (file-modes name)))
                (set-file-modes name (logior mode (logand (/ mode 4) 73)))
                (message (concat "Wrote " name " (+x)"))))))))
(add-hook 'after-save-hook 'make-file-executable)



