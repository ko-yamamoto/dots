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
;; ヘルプコマンドをC-^に割り当てる
(global-set-key "\C-^" 'help-command)

;; 共通ロードパスを通す OSごと設定は下の方で
(setq load-path (cons "~/.emacs.d/elisp" load-path))
;; ;; emacs.d/elisp以下を再帰的にload-pathへ追加
;; (let ((default-directory (expand-file-name "~/.emacs.d/elisp")))
;;   (add-to-list 'load-path default-directory)
;;   (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;;       (normal-top-level-add-subdirs-to-load-path)))

;; package.elでインストールしたelispをload-pathへ追加
(let ((default-directory (expand-file-name "~/.emacs.d/elpa")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

;; language & code
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

;; beepを消す
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; 起動時のメッセージを非表示
(setq inhibit-startup-message t)

;; "yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)

;; 現在カーソル位置のファイルパス/URLを開く
;; (ffap-bindings)

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
(setq recentf-keep '(file-remote-p file-readable-p))
(setq recentf-auto-cleanup 'never)
;; 最近使ったファイルに加えないファイルを正規表現で指定する
(setq recentf-exclude '("/TAGS$" "/var/tmp/" "^/[^/:]+:"))

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
;;クライアントを終了するとき終了するかどうかを聞かない
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

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
;;   `( ;; vi-like
;;     ("h" . backward-word)
;;     ("l" . forward-word)
;;     ("j" . next-line)
;;     ("k" . previous-line)
;;     (";" . gene-word)
;;     ("b" . scroll-down)
;;     (" " . scroll-up)
;;     ;; w3m-like
;;     ("m" . gene-word)
;;     ("i" . win-delete-current-window-and-squeeze)
;;     ("w" . forward-word)
;;     ("e" . backward-word)
;;     ("(" . point-undo)
;;     (")" . point-redo)
;;     ("J" . ,(lambda () (interactive) (scroll-up 1)))
;;     ("K" . ,(lambda () (interactive) (scroll-down 1)))
;;     ;; bm-easy
;;     ("." . bm-toggle)
;;     ("[" . bm-previous)
;;     ("]" . bm-next)
;;     ;; langhelp-like
;;     ("c" . scroll-other-window-down)
;;     ("v" . scroll-other-window)
;;     ))

;; (defun define-many-keys (keymap key-table &optional includes)
;;   (let (key cmd)
;;     (dolist (key-cmd key-table)
;;       (setq key (car key-cmd)
;;             cmd (cdr key-cmd))
;;       (if (or (not includes) (member key includes))
;;           (define-key keymap key cmd))))
;;   keymap)


;; (defun view-mode-hook0 ()
;;   (define-many-keys view-mode-map pager-keybind)
;;   (hl-line-mode 1)
;;   (define-key view-mode-map " " 'scroll-up))
;; (add-hook 'view-mode-hook 'view-mode-hook0)


;; 書き込み不能なファイルはview-modeで開くように
(defadvice find-file
  (around find-file-switch-to-view-file (file &optional wild) activate)
  (if (and (not (file-writable-p file))
           (not (file-directory-p file)))
      (view-file file)
    ad-do-it))

;; 書き込み不能な場合はview-modeを抜けないように
(defvar view-mode-force-exit nil)
(defmacro do-not-exit-view-mode-unless-writable-advice (f)
  `(defadvice ,f (around do-not-exit-view-mode-unless-writable activate)
     (if (and (buffer-file-name)
              (not view-mode-force-exit)
              (not (file-writable-p (buffer-file-name))))
         (message "File is unwritable, so stay in view-mode.")
       ad-do-it)))

(do-not-exit-view-mode-unless-writable-advice view-mode-exit)
(do-not-exit-view-mode-unless-writable-advice view-mode-disable)

;; C-q -> pre-fix key
(define-key global-map "\C-q" (make-sparse-keymap))
;; quoted-insert -> C-q C-q
(global-set-key "\C-q\C-q" 'quoted-insert)

;; window move
(global-set-key "\C-ql" 'windmove-right)
(global-set-key "\C-qh" 'windmove-left)
(global-set-key "\C-qj" 'windmove-down)
(global-set-key "\C-qk" 'windmove-up)

;; window split
(global-set-key "\C-qsq" 'my/buffer-kill-and-delete-window)
(global-set-key "\C-qs1" 'delete-other-windows)
(global-set-key "\C-qsv" 'split-window-vertically)
(global-set-key "\C-qsp" 'split-window-horizontally)


(defun window-toggle-division ()
  "ウィンドウ 2 分割時に、縦分割<->横分割"
  (interactive)
  (unless (= (count-windows 1) 2)
    (error "ウィンドウが 2 分割されていません。"))
  (let (before-height (other-buf (window-buffer (next-window))))
    (setq before-height (window-height))
    (delete-other-windows)

    (if (= (window-height) before-height)
        (split-window-vertically)
      (split-window-horizontally)
      )

    (switch-to-buffer-other-window other-buf)
    (other-window -1)))
(global-set-key (kbd "C-q s r") 'window-toggle-division)


(defun reopen-file ()
  "undo 可能なようにファイルを開き直す"
  (interactive)
  (let ((file-name (buffer-file-name))
        (old-supersession-threat
         (symbol-function 'ask-user-about-supersession-threat))
        (point (point)))
    (when file-name
      (fset 'ask-user-about-supersession-threat (lambda (fn)))
      (unwind-protect
          (progn
            (erase-buffer)
            (insert-file file-name)
            (set-visited-file-modtime)
            (goto-char point))
        (fset 'ask-user-about-supersession-threat
              old-supersession-threat)))))
(global-set-key (kbd "C-x C-r") 'reopen-file)

;; ウィンドウ移動を楽に
;; (define-key global-map (kbd "C-t") 'other-window)
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))
(global-set-key (kbd "C-t") 'other-window-or-split)
(define-key dired-mode-map (kbd "C-t") 'other-window-or-split)

;; (makunbound 'overriding-minor-mode-map)
;; (define-minor-mode overriding-minor-mode
;;   "強制的にC-tを割り当てる"             ;説明文字列
;;   t                                     ;デフォルトで有効にする
;;   ""                                    ;モードラインに表示しない
;;   `((,(kbd "C-t") . other-window-or-split)))


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

;; 折り返しあり
(setq truncate-lines nil)
;; 画面分割してもデフォルトで折り返す
(setq truncate-partial-width-windows nil)

;; Emacs 終了時にプロセスを自動で殺す
(defadvice save-buffers-kill-terminal (before my-save-buffers-kill-terminal activate)
  (when (process-list)
    (dolist (p (process-list))
      (set-process-query-on-exit-flag p nil))))

;; 大文字変換を使用する
(put 'upcase-region 'disabled nil)

;; ミニバッファで C-w すると単語ではなく1つ上のパスまでを削除
(define-key minibuffer-local-completion-map "\C-w" 'backward-kill-word)


;; Autosave every 500 typed characters
(setq auto-save-interval 500)

;; スクロール設定
(setq hscroll-step                    1
      scroll-conservatively           10000
      scroll-preserve-screen-position t
      auto-window-vscroll             nil           ; speedup down scroll
      scroll-margin                   5
      redisplay-dont-pause            t             ; this will be default in emacs24
      )

;; tail -f
;;http://d.hatena.ne.jp/kitokitoki/20100706/p1
(make-face 'my-highlight-face)
(set-face-foreground 'my-highlight-face "#de935f")
;;(set-face-background 'my-highlight-face "yellow")
(setq my-highlight-face 'my-highlight-face)

(defun my-keep-highlight-regexp (re)
  (interactive "sRegexp: \n")
  (setq my-highlight-keyword re)
  (my-keep-highlight-set-font-lock my-highlight-keyword))

(defun my-keep-highlight-symbole-at-point ()
  (interactive)
  (setq my-highlight-keyword (or (thing-at-point 'symbol) ""))
  (my-keep-highlight-set-font-lock my-highlight-keyword))

(defun my-keep-highlight-set-font-lock (re)
  (font-lock-add-keywords 'nil (list (list re 0 my-highlight-face t)))
  (font-lock-fontify-buffer))

(defun my-cancel-highlight-regexp ()
  (interactive)
  (font-lock-remove-keywords 'nil (list (list my-highlight-keyword 0 my-highlight-face t)))
  (font-lock-fontify-buffer))

;; (defalias 'h 'my-keep-highlight-regexp)

;; 保存時に余計なスペースとタブを取り除く
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; 改行とインデント
(global-set-key (kbd "C-m") 'newline-and-indent)

;; 変更のあったファイルの自動再読み込み
(global-auto-revert-mode t)

;; ロケールは C で統一しておく
(setq system-time-locale "C")

;; バッファの終端を明示する
(setq-default indicate-empty-lines t)

;; forward-word は単語頭に移動する
;; my-forward-word.el - https://gist.github.com/mori-dev/409070
;; (defun my-forward-word (arg)
;;   (interactive "p")
;;   (cond
;;    ((region-active-p) (forward-word arg))
;;    ((looking-at ".$") (re-search-forward "\\W\\b\\"))
;;    ((looking-at "\\cj") (forward-word arg))
;;    ((looking-at "\\(。\\|、\\|．\\|，\\)") (re-search-forward "\[。、．，\]+"))
;;    (t (re-search-forward "\\(.$\\|\\W\\b\\)"))))
;; ;;; For compatibility
;; (unless (fboundp 'region-active-p)
;;   (defun region-active-p ()
;;     (and transient-mark-mode mark-active)))
;; (global-set-key (kbd "M-f") 'my-forward-word)

;; 「Emacsのトラノマキ」連載第16回「元Vimmerが考えるEmacsの再設計」(深町英太郎) | ありえるえりあ - http://dev.ariel-networks.com/wp/documents/aritcles/emacs/part16
;; 範囲指定していないとき、C-wで前の単語を削除
(defadvice kill-region (around kill-word-or-kill-region activate)
  (if (and (interactive-p) transient-mark-mode (not mark-active))
      (backward-kill-word 1)
    ad-do-it))
;; minibuffer用
(define-key minibuffer-local-completion-map (kbd "C-w") 'backward-kill-word)

;; カーソル位置の単語を削除
(defun kill-word-at-point ()
  (interactive)
  (let ((char (char-to-string (char-after (point)))))
    (cond
     ((string= " " char) (delete-horizontal-space))
     ((string-match "[\t\n -@\[-`{-~]" char) (kill-word 1))
     (t (forward-char) (backward-word) (kill-word 1)))))
(global-set-key (kbd "M-d") 'kill-word-at-point)

;; kill-lineで行が連結したときにインデントを減らす
(defadvice kill-line (before kill-line-and-fixup activate)
  (when (and (not (bolp)) (eolp))
    (forward-char)
    (fixup-whitespace)
    (backward-char)))

;; ウィンドウと同時にバッファも閉じる
(substitute-key-definition 'kill-buffer 'kill-buffer-and-its-windows global-map)

;; 同名の .el と .elc があれば新しい方を読み込む
(setq load-prefer-newer t)

;; スペース 1 つ残し、スペースなしをトグル
(global-set-key (kbd "M-SPC") 'cycle-spacing)
