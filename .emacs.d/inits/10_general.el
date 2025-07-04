(use-package key-chord
  :config
  (key-chord-mode 1)
  (setq key-chord-one-keys-delay 0.04)

  ;; don't hijack input method!
  (advice-add 'toggle-input-method :around
              (lambda (orig-fun &rest args)
                (let ((input-method-function-save input-method-function))
                  (apply orig-fun args)
                  (setq input-method-function input-method-function-save))))
  (key-chord-define-global "mk" 'kill-buffer)
  (key-chord-define-global "MK" 'my/buffer-kill-and-delete-window)

  (key-chord-define-global "cl" 'toggle-truncate-lines)

  )


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

;; language & code
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-time-zone-rule "GMT-9")

;; beepを消す
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; "yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)

;; タブは4
(setq-default tab-width 4)
(setq default-tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                        64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
;; タブはスペースで
(setq-default tab-width 4 indent-tabs-mode nil)

;; ディレクトリも履歴に残るように
(use-package recentf-ext
  :config
  (recentf-mode 1))

;; 最近のファイル500個を保存する
(setq recentf-max-saved-items 1000)
(setq recentf-max-menu-items 300)
(setq recentf-keep '(file-remote-p file-readable-p))
(setq recentf-auto-cleanup 'never)
;; 最近使ったファイルに加えないファイルを正規表現で指定する
(setq recentf-exclude '("/TAGS$" "/var/tmp/" "^/[^/:]+:"))
;; (setq recentf-exclude '("/TAGS$" "/var/tmp/"))

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

;; リージョン選択した状態でisearchすると選択後を検索
(advice-add 'isearch-mode :around
            (lambda (orig-fun forward &optional regexp op-fun recursive-edit word-p)
              (if (and transient-mark-mode mark-active (not (eq (mark) (point))))
                  (progn
                    (isearch-update-ring (buffer-substring-no-properties (mark) (point)))
                    (deactivate-mark)
                    (funcall orig-fun forward regexp op-fun recursive-edit word-p)
                    (if (not forward)
                        (isearch-repeat-backward)
                      (goto-char (mark))
                      (isearch-repeat-forward)))
                (funcall orig-fun forward regexp op-fun recursive-edit word-p))))

;; 書き込み不能なファイルはview-modeで開くように
(advice-add 'find-file :around
            (lambda (orig-fun file &optional wild)
              (if (and (not (file-writable-p file))
                       (not (file-directory-p file)))
                  (view-file file)
                (funcall orig-fun file wild))))

;; 書き込み不能な場合はview-modeを抜けないように
(defvar view-mode-force-exit nil)
(defun do-not-exit-view-mode-unless-writable-advice (orig-fun &rest args)
  (if (and (buffer-file-name)
           (not view-mode-force-exit)
           (not (file-writable-p (buffer-file-name))))
      (message "File is unwritable, so stay in view-mode.")
    (apply orig-fun args)))

(advice-add 'view-mode-exit :around #'do-not-exit-view-mode-unless-writable-advice)
(advice-add 'view-mode-disable :around #'do-not-exit-view-mode-unless-writable-advice)

;; C-q -> pre-fix key
;; (define-key global-map "\C-q" (make-sparse-keymap))
;; quoted-insert -> C-q C-q
(global-set-key "\C-q\C-q" 'quoted-insert)

;; window move
;; (global-set-key "\C-ql" 'windmove-right)
;; (global-set-key "\C-qh" 'windmove-left)
;; (global-set-key "\C-qj" 'windmove-down)
;; (global-set-key "\C-qk" 'windmove-up)

;; window split
;; (global-set-key "\C-qsq" 'my/buffer-kill-and-delete-window)
(global-set-key "\C-q1" 'delete-other-windows)
(global-set-key "\C-qv" 'split-window-vertically)
(global-set-key "\C-qs" 'split-window-horizontally)

(global-set-key (kbd "C-q 0") 'delete-window)

(defun window-split-toggle ()
  "ウィンドウ 2 分割時に、縦分割<->横分割"
  (interactive)
  (if (> (length (window-list)) 2)
      (error "Can't toggle with more than 2 windows!")
    (let ((func (if (window-full-height-p)
                    #'split-window-vertically
                  #'split-window-horizontally)))
      (delete-other-windows)
      (funcall func)
      (save-selected-window
        (other-window 1)
        (switch-to-buffer (other-buffer))))))
(global-set-key (kbd "C-q SPC") 'window-split-toggle)

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
;; (global-set-key (kbd "C-x C-r") 'reopen-file)
(global-set-key (kbd "C-x C-r") 'revert-buffer)

;; ウィンドウ移動を楽に
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))
(global-set-key (kbd "C-t") 'other-window-or-split)

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

;; Emacs 終了時にプロセスを自動で殺す
(advice-add 'save-buffers-kill-terminal :before
            (lambda (&rest _args)
              (when (process-list)
                (dolist (p (process-list))
                  (set-process-query-on-exit-flag p nil)))))

;; 大文字変換を使用する
(put 'upcase-region 'disabled nil)

;; ミニバッファで C-w すると単語ではなく1つ上のパスまでを削除
(define-key minibuffer-local-completion-map "\C-w" 'backward-kill-word)

;; 単語削除は kill-ring に入れない
(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))
(defun backward-delete-word (arg)
  "Delete characters backward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-word (- arg)))

(defun kill-region-or-backward-word ()
  "If the region is active and non-empty, call `kill-region'.
Otherwise, call `backward-kill-word'."
  (interactive)
  (call-interactively
   (if (use-region-p) 'kill-region 'backward-delete-word)))
(global-set-key (kbd "C-w") 'kill-region-or-backward-word)


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

;; 保存時に余計なスペースとタブを取り除く
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; 改行とインデント
;; (global-set-key (kbd "C-m") 'newline-and-indent)

;; 変更のあったファイルの自動再読み込み
(global-auto-revert-mode t)

;; ロケールは C で統一しておく
(setq system-time-locale "C")

;; forward-word は単語頭に移動する
;; my-forward-word.el - https://gist.github.com/mori-dev/409070
(defun my-forward-word (arg)
  (interactive "p")
  (cond
   ((region-active-p) (forward-word arg))
   ((looking-at ".$") (re-search-forward "\\W\\b\\"))
   ((looking-at "\\cj") (forward-word arg))
   ((looking-at "\\(。\\|、\\|．\\|，\\)") (re-search-forward "\[。、．，\]+"))
   (t (re-search-forward "\\(.$\\|\\W\\b\\)"))))
;;; For compatibility
(unless (fboundp 'region-active-p)
  (defun region-active-p ()
    (and transient-mark-mode mark-active)))
(global-set-key (kbd "M-f") 'my-forward-word)

;; kill-lineで行が連結したときにインデントを減らす
(advice-add 'kill-line :before
            (lambda (&rest _args)
              (when (and (not (bolp)) (eolp))
                (forward-char)
                (fixup-whitespace)
                (backward-char))))

;; 同名の .el と .elc があれば新しい方を読み込む
(setq load-prefer-newer t)

;; リージョンで C-d したらリージョンごと削除できるように
(delete-selection-mode t)

;; コマンド履歴を永続的に残す
(setq history-length 250)
;; (setq desktop-globals-to-save '(extended-command-history
;;                                 desktop-missing-file-warning
;;                                 search-ring
;;                                 regexp-search-ring
;;                                 file-name-history))
;; (setq desktop-files-not-to-save "")
(desktop-save-mode 1)


;; Emacs serverを起動
(require 'server)
(when (and (>= emacs-major-version 23)
           (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t)) ; Suppress error "directory
                                        ; ~/.emacs.d/server is unsafe"
                                        ; on windows.
(server-start)
;;クライアントを終了するとき終了するかどうかを聞かない
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;; ブラウザを設定
;; (setq browse-url-generic-program
;; (executable-find (getenv "BROWSER"))
;; browse-url-browser-function 'browse-url-generic)

(use-package zlc
  :config
  (zlc-mode t)
  (let ((map minibuffer-local-map))
  ;;; like menu select
    (define-key map (kbd "<down>")  'zlc-select-next-vertical)
    (define-key map (kbd "<up>")    'zlc-select-previous-vertical)
    (define-key map (kbd "<right>") 'zlc-select-next)
    (define-key map (kbd "<left>")  'zlc-select-previous)

  ;;; reset selection
    (define-key map (kbd "C-c") 'zlc-reset)
    )
  )

;; 誤爆するので外す
(global-unset-key (kbd "C-z"))

;; タブ表示する
(use-package tab-bar
  :straight (:type built-in)
  :custom
  (tab-bar-close-button-show nil)
  (tab-bar-new-button-show nil)
  (tab-bar-history-limit 25)
  (tab-bar-new-tab-choice "*scratch*")
  (tab-bar-show t)
  (tab-bar-tab-hints t)
  :config
  (tab-bar-mode 1)
  (global-set-key (kbd "<C-tab>") 'tab-bar-switch-to-next-tab)
  (global-set-key (kbd "<C-S-tab>") 'tab-bar-switch-to-prev-tab)
  (global-set-key (kbd "<C-S-iso-lefttab>") 'tab-bar-switch-to-prev-tab)
)

;; 次に入力するキーとコマンドを教えてくれる
(use-package which-key
  :straight t
  :init
  (which-key-mode))


(setq native-comp-async-report-warnings-errors 'silent)

