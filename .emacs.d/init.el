;;====================
;; StartSettings
;;====================

;; 環境切り分け用の定義作成
(defvar is_emacs22 (equal emacs-major-version 22))
(defvar is_emacs23 (equal emacs-major-version 23))
(defvar is_window-sys (not (eq (symbol-value 'window-system) nil)))
;; Mac全般のとき
(defvar is_mac (or (eq window-system 'mac) (featurep 'ns)))
;; Carbon Emacsのとき
(defvar is_carbon (and is_mac is_emacs22 is_window-sys))
;; Cocoa Emacsのとき
(defvar is_cocoa (and is_mac is_emacs23 is_window-sys))
(defvar is_inline-patch (eq (boundp 'mac-input-method-parameters) t))
(defvar is_darwin (eq system-type 'darwin))
;; cygwinのとき
(defvar is_cygwin (eq system-type 'cygwin))
;; winNTのとき
(defvar is_winnt  (eq system-type 'windows-nt))
;; Win全般のとき
(defvar is_win (or is_cygwin is_winnt))


;;====================
;; General
;;====================

(load "term/bobcat")
(when (fboundp 'terminal-init-bobcat) (terminal-init-bobcat))

;; ロードパスを通す
(setq load-path (cons "~/.emacs.d/elisp" load-path))

;; ウィンドウサイズ設定
(setq initial-frame-alist
      (append (list
	     '(width . 140) ;; ウィンドウ幅
	       '(height . 50) ;; ウィンドウ高さ
;	       '(top . 50) ;; 表示位置
;	       '(left . 340) ;; 表示位置
	       )
	      initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)


; ごみ箱を有効
(setq delete-by-moving-to-trash t)


;; バックアップファイルの;; 場所
;; (when is_mac
;; (setq make-backup-files t)
;; (setq backup-directory "/Volumes/RamDisk/emacsBackup")
;; )
;; (when is_win 
;; (setq make-backup-files t)
;; (setq backup-directory "R:/")
;; )

;; バックアップファイルを作らない
(setq backup-inhibited t)

;; オートセーブしない
;;(setq make-backup-files nil)

;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)


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


;; scroll
(require 'smooth-scroll)
(smooth-scroll-mode t)

;; smooth scroll of the buffer
(set-variable 'smooth-scroll/vscroll-step-size 8)
(set-variable 'smooth-scroll/hscroll-step-size 8)
;; (setq scroll-step 1
;; scroll-conservatively 10000)


;; 1画面戻る(M-v)を"Ctr-Shift-v"にも
(global-set-key (kbd "C-S-v") 'scroll-down)


;; anything
(require 'anything-startup)
(define-key global-map (kbd "C-;") 'anything)
(setq
 ;; ショートカットアルファベット表示
 anything-enable-shortcuts 'alphabet
 ;; 候補表示までの時間
 anything-idle-delay 0.3
 ;; 候補の多いときに体感速度を上げる
 anything-quick-update t
)
(require 'anything-config)
(setq anything-sources
      '(anything-c-source-buffers+
	anything-c-source-recentf
	anything-c-source-emacs-commands
	anything-c-source-emacs-functions
	anything-c-source-files-in-current-dir
	))


;; anything-kyr
(require 'anything-kyr-config)
;; anything-complete.el があれば読み込む
(when (require 'anything-complete nil t)
  ;; 補完を anything でやりたいならば
(anything-read-string-mode 1))


;; kill-ringもanythigで
(global-set-key (kbd "M-y") 'anything-show-kill-ring)


;; dired-x
(require 'dired-x)

;; wdired
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

(defvar dired-various-sort-type
  '(("S" . "size")
    ("X" . "extension")
    ("v" . "version")
    ("t" . "date")
    (""  . "name")))


;; dired
(defun dired-various-sort-change (sort-type-alist &optional prior-pair)
  (when (eq major-mode 'dired-mode)
    (let* (case-fold-search
           get-next
           (options
            (mapconcat 'car sort-type-alist ""))
           (opt-desc-pair
            (or prior-pair
                (catch 'found
                  (dolist (pair sort-type-alist)
                    (when get-next
                      (throw 'found pair))
                    (setq get-next (string-match (car pair) dired-actual-switches)))
                  (car sort-type-alist)))))
      (setq dired-actual-switches
            (concat "-l" (dired-replace-in-string (concat "[l" options "-]")
                                                  ""
                                                  dired-actual-switches)
                    (car opt-desc-pair)))
      (setq mode-name
            (concat "Dired by " (cdr opt-desc-pair)))
      (force-mode-line-update)
      (revert-buffer))))

(defun dired-various-sort-change-or-edit (&optional arg)
  "Hehe"
  (interactive "P")
  (when dired-sort-inhibit
    (error "Cannot sort this dired buffer"))
  (if arg
      (dired-sort-other
       (read-string "ls switches (must contain -l): " dired-actual-switches))
    (dired-various-sort-change dired-various-sort-type)))

(defvar anything-c-source-dired-various-sort
  '((name . "Dired various sort type")
    (candidates . (lambda ()
                    (mapcar (lambda (x)
                              (cons (concat (cdr x) " (" (car x) ")") x))
                            dired-various-sort-type)))
    (action . (("Set sort type" . (lambda (candidate)
                                    (dired-various-sort-change dired-various-sort-type candidate)))))
    ))


(add-hook 'dired-mode-hook
          '(lambda ()
             (define-key dired-mode-map "s" 'dired-various-sort-change-or-edit)
             (define-key dired-mode-map "c"
               '(lambda ()
                  (interactive)
                  (anything '(anything-c-source-dired-various-sort))))
             ))


;; diredでマークをつけたファイルをfind/view
(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map "F" 'my-dired-find-file)
     (defun my-dired-find-file (&optional arg)
       "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
       (interactive "P")
       (let* ((fn-list (dired-get-marked-files nil arg)))
         (mapc 'find-file fn-list)))
     (define-key dired-mode-map "V" 'my-dired-view-file)
     (defun my-dired-view-file (&optional arg)
       "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
       (interactive "P")
       (let* ((fn-list (dired-get-marked-files nil arg)))
         (mapc 'view-file fn-list)))))


;; diredでのファイルコピーを便利に
(setq dired-dwim-target t)

;;; フォルダを開く時, 新しいバッファを作成しない
;; バッファを作成したい時にはoやC-u ^を利用する
(defvar my-dired-before-buffer nil)
(defadvice dired-advertised-find-file
  (before kill-dired-buffer activate)
  (setq my-dired-before-buffer (current-buffer)))
(defadvice dired-advertised-find-file
  (after kill-dired-buffer-after activate)
  (if (eq major-mode 'dired-mode)
      (kill-buffer my-dired-before-buffer)))
(defadvice dired-up-directory
  (before kill-up-dired-buffer activate)
  (setq my-dired-before-buffer (current-buffer)))
(defadvice dired-up-directory
  (after kill-up-dired-buffer-after activate)
  (if (eq major-mode 'dired-mode)
      (kill-buffer my-dired-before-buffer)))


;; Quick Look
(setq dired-load-hook '(lambda () (load "dired-x"))) 
(setq dired-guess-shell-alist-user
      '(("\\.png" "qlmanage -p")
        ("\\.jpg" "qlmanage -p")
        ("\\.pdf" "qlmanage -p")))


;; 矩形処理
(cua-mode t)
(setq cua-enable-cua-keys nil) ;; 変なキーバインド禁止


;; ビューモード
(setq view-read-only t)
(defvar pager-keybind
      `( ;; vi-like
        ("h" . backward-word)
        ("l" . forward-word)
        ("j" . next-line)
        ("k" . previous-line)
        (";" . gene-word)
        ("b" . scroll-down)
        (" " . scroll-up)
        ;; w3m-like
        ("m" . gene-word)
        ("i" . win-delete-current-window-and-squeeze)
        ("w" . forward-word)
        ("e" . backward-word)
        ("(" . point-undo)
        (")" . point-redo)
        ("J" . ,(lambda () (interactive) (scroll-up 1)))
        ("K" . ,(lambda () (interactive) (scroll-down 1)))
        ;; bm-easy
        ("." . bm-toggle)
        ("[" . bm-previous)
        ("]" . bm-next)
        ;; langhelp-like
        ("c" . scroll-other-window-down)
        ("v" . scroll-other-window)
        ))

(defun define-many-keys (keymap key-table &optional includes)
  (let (key cmd)
    (dolist (key-cmd key-table)
      (setq key (car key-cmd)
            cmd (cdr key-cmd))
      (if (or (not includes) (member key includes))
        (define-key keymap key cmd))))
  keymap)


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


(require 'thing-opt)
(define-thing-commands)


;; Keycordの設定
(require 'key-chord)
(key-chord-mode 1)
(setq key-chord-one-keys-delay 0.04)

;; don't hijack input method!
(defadvice toggle-input-method (around toggle-input-method-around activate)
  (let ((input-method-function-save input-method-function))
    ad-do-it
    (setq input-method-function input-method-function-save)))
(key-chord-define-global "jk" 'view-mode)
(key-chord-define-global "dw" 'kill-word*)
(key-chord-define-global "yw" 'copy-word)
(key-chord-define-global "vw" 'mark-word*)
(key-chord-define-global "ds" 'kill-sexp*)
(key-chord-define-global "ys" 'copy-sexp)
(key-chord-define-global "vs" 'mark-sexp*)
(key-chord-define-global "dq" 'kill-string)
(key-chord-define-global "yq" 'copy-string)
(key-chord-define-global "vq" 'mark-string)
(key-chord-define-global "nm" 'copy-line)
(key-chord-define-global "lm" 'mark-line)
(key-chord-define-global "nj" 'kill-line)
(key-chord-define-global "dl" 'kill-up-list)
(key-chord-define-global "yl" 'copy-up-list)
(key-chord-define-global "vl" 'mark-up-list)
(key-chord-define-global ",."     "<>\C-b")
(key-chord-define-global "[]"     "{}\C-b")
(key-chord-define-global "89"     "()\C-b")
(key-chord-define-global "w2"     "\"\"\C-b")
;; (key-chord-define-global "00" 'delete-window)
;; (key-chord-define-global "11" 'delete-other-windows)
;; (key-chord-define-global "22" 'split-window-vertically)
;; (key-chord-define-global "33" 'split-window-horizontally)
(key-chord-define-global "mk" 'kill-buffer)
(key-chord-define-global "cv" 'scroll-up)
(key-chord-define-global "vb" 'scroll-down)


;; M-Yで今の行を下にコピー
;; (defun duplicate-line (&optional numlines)
;;   "One line is duplicated wherever there is a cursor."
;;   (interactive "p")
;;   (let* ((col (current-column))
;;          (bol (progn (beginning-of-line) (point)))
;;          (eol (progn (end-of-line) (point)))
;;          (line (buffer-substring bol eol)))
;;     (while (> numlines 0)
;;       (insert "\n" line)
;;       (setq numlines (- numlines 1)))
;;     (move-to-column col)))
;;(define-key esc-map "Y" 'duplicate-line)


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


;; anything-show-kill-ringでやるようにしたのでコメントアウト
    ;; ;; browse-kill-ring
    ;; (require 'browse-kill-ring)
    ;; (global-set-key "\M-y" 'browse-kill-ring)
    ;; ;; kill-ring を一行で表示
    ;;  ;;(setq browse-kill-ring-display-style 'one-line)
    ;; ;; browse-kill-ring 終了時にバッファを kill する
    ;; (setq browse-kill-ring-quit-action 'kill-and-delete-window)
    ;; ;; 必要に応じて browse-kill-ring のウィンドウの大きさを変更する
    ;; (setq browse-kill-ring-resize-window t)
    ;; ;; kill-ring の内容を表示する際の区切りを指定する
    ;; (setq browse-kill-ring-separator "-------")
    ;; ;; 現在選択中の kill-ring のハイライトする
    ;; (setq browse-kill-ring-highlight-current-entry t)
    ;; ;; 区切り文字のフェイスを指定する
    ;; (setq browse-kill-ring-separator-face 'region)
    ;; ;; 一覧で表示する文字数を指定する． nil ならすべて表示される．
    ;; (setq browse-kill-ring-maximum-display-length 100)


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


;; key-chordにも登録
(key-chord-define-global "ql" 'windmove-right)
(key-chord-define-global "qh" 'windmove-left)
(key-chord-define-global "qj" 'windmove-down)
(key-chord-define-global "qk" 'windmove-up)

;; C-tでウインドウ分割/移動
;; (defun other-window-or-split ()
;;   (interactive)
;;   (when (one-window-p)
;;     (split-window-horizontally))
;;   (other-window 1))
;; (global-set-key (kbd "C-t") 'other-window-or-split)


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


;; twittering-mode
(require 'twittering-mode)


;; 最近のファイル500個を保存する
(setq recentf-max-saved-items 1000)

;; 最近使ったファイルに加えないファイルを正規表現で指定する
(setq recentf-exclude '("/TAGS$" "/var/tmp/"))
(require 'recentf-ext)


;; point-undo 
(require 'point-undo)
(define-key global-map (kbd "<f7>") 'point-undo)
(define-key global-map (kbd "S-<f7>") 'point-redo)


;; 最後の変更箇所にジャンプ
(require 'goto-chg)
(define-key global-map (kbd "<f8>") 'goto-last-change)
(define-key global-map (kbd "S-<f8>") 'goto-last-change-reverse)


(require 'color-moccur)
(setq moccur-split-word t)


(require 'moccur-edit)
(setq moccur-split-word t)




;;====================
;; For Mac
;;====================

(when is_mac

;; フォント設定
(setq my-font "-*-*-medium-r-normal--12-*-*-*-*-*-fontset-hiramaru")
(set-face-attribute 'default nil
		    :family "Monaco"
		    :height 110)
		    ;:height 90)
(set-fontset-font "fontset-default"
		  'japanese-jisx0208
		  '("VL_Gothic" . "iso10646-1"))
(set-fontset-font "fontset-default"
		  'katakana-jisx0201
		  '("VL_Gothic" . "iso10646-1"))
(setq face-font-rescale-alist
      '((".*Monaco-bold.*" . 1.0)
	(".*Monaco-medium.*" . 1.0)
	(".*Osaka-bold.*" . 1.0)
	(".*Osaka-medium.*" . 1.0)
	("-cdac$" . 1.4)))


;; PATH
;(setq exec-path (cons "/usr/local/bin" exec-path))
(setq exec-path
  (append
    (list "/usr/local/bin" "/usr/local/scala/bin" "~/bin")exec-path)) 
(setenv "PATH"
    (concat '"/usr/local/bin:" (getenv "PATH")))


;; Command-Key and Option-Key
;; コマンドキーをMetaに、Optionキーをsuperに
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))


;; CmdキーをSuperに、OptionキーをMetaに
;; (setq mac-option-modifier 'meta)
;; (setq mac-command-modifier 'super)


;; Cmd+cでコピー、Cmd+xで切り取り、Cmd+vではりつけ
(global-set-key [(super c)] 'kill-ring-save)
(global-set-key [(super v)] 'yank)
(global-set-key [(super x)] 'kill-region)


;; zshを使う
(setq shell-file-name "/usr/local/bin/zsh")
;; zshで4mとか出る問題に対応
;; (setq system-uses-terminfo nil)
;; lsで色崩れ防ぐ
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;; C-tでshellをポップアップ
(require 'shell-pop)
(shell-pop-set-internal-mode "ansi-term") ;; ansi-termを使うよ
(shell-pop-set-internal-mode-shell "/usr/local/bin/zsh") ;; zshを使うよ
(defvar ansi-term-after-hook nil)
(add-hook 'ansi-term-after-hook
          '(lambda ()
             (define-key term-raw-map "\C-t" 'shell-pop)))
(defadvice ansi-term (after ansi-term-after-advice (org))
  "run hook as after advice"
  (run-hooks 'ansi-term-after-hook))
(ad-activate 'ansi-term)
(global-set-key "\C-t" 'shell-pop)
;; (defvar my-shell-pop-key (kbd "C-t"))
;; (defvar my-ansi-term-toggle-mode-key (kbd "<f2>"))

(shell-pop-set-window-height 50)
(shell-pop-set-internal-mode "ansi-term")
(shell-pop-set-internal-mode-shell shell-file-name)



)



;;====================
;; For Win
;;====================

(when is_win

  ;; PATH
  ;(setq exec-path (cons "/usr/local/bin" exec-path))
  (setq exec-path
    (append
      (list "C:/scala/scala-2.8.1.final/bin"
	    "C:/Python27"
	    "C:/cygwin/bin"
	    "C:/Windows/system32/"
	    "C:/Windows/"
      )exec-path)) 
  (setenv "PATH"
      (concat '"C:/cygwin/bin:C:/scala/scala-2.8.1.final/bin:C:/Python27" (getenv "PATH")))


  ;; ツールバーを消す
  (tool-bar-mode nil)


  ;; ファイル名の文字コード指定
  (setq file-name-coding-system 'shift_jis)

  ;; フォント設定
  (setq my-font "-*-*-medium-r-normal--14-*-*-*-*-*-fontset-hiramaru")
  (set-face-attribute 'default nil
		    :family "VL ゴシック"
		    ;:height 120)
		    :height 90)
  (set-fontset-font "fontset-default"
		  'japanese-jisx0208
		  '("VL ゴシック" . "iso10646-1"))


  ;; プロクシの設定
  (setq url-proxy-services '(("http" . "192.168.1.8:8080")))


;; (setq mw32-process-wrapper-alist
;;       '(("/\\(zsh\\|\\(bash\\|tcsh\\|svn\\|ssh\\|gpg[esvk]?\\)\\.exe" .
;; 	 (nil . "fakecygpty.exe"))))
;;   ;; shell の存在を確認
;;   (defun skt:shell ()
;;     (or ;;(executable-find "zsh")
;;         ;;(executable-find "bash")
;;         (executable-find "f_zsh") ;; Emacs + Cygwin を利用する人は Zsh の代りにこれにしてください
;;         (executable-find "f_bash") ;; Emacs + Cygwin を利用する人は Bash の代りにこれにしてください
;;         (executable-find "cmdproxy")
;;         (error "can't find 'shell' command in PATH!!")))
;;   ;; Shell 名の設定
;;   (setq shell-file-name (skt:shell))
;;   (setenv "SHELL" shell-file-name)
;;   (setq explicit-shell-file-name shell-file-name)
;;   ;; 文字コード設定
;;   (set-language-environment  'utf-8)
;;   (prefer-coding-system 'utf-8)
;; ;; ;; ターミナルない文字コード設定
;; ;; (cond
;; ;;  (
;; ;;  (or (eq system-type 'cygwin) (eq system-type 'windows-nt)
;; ;;   (setq file-name-coding-system 'utf-8)
;; ;;   (setq locale-coding-system 'utf-8)
;; ;;   ;; もしコマンドプロンプトを利用するなら sjis にする
;; ;;   ;; (setq file-name-coding-system 'sjis)
;; ;;   ;; (setq locale-coding-system 'sjis)
;; ;;   ;; 古い Cygwin だと EUC-JP にする
;; ;;   ;; (setq file-name-coding-system 'euc-jp)
;; ;;   ;; (setq locale-coding-system 'euc-jp)
;; ;;   )
;; ;;  (t
;; ;;   (setq file-name-coding-system 'utf-8)
;; ;;   (setq locale-coding-system 'utf-8)))
;;   ;; Emacs が保持する terminfo を利用する
;;   (setq system-uses-terminfo nil)
;;   ;; lsなどのエスケープをキレイに
;;   (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
;;   (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;;   ;; ターミナル起動キー
;;   (global-set-key (kbd "C-t") '(lambda ()
;;                                 (interactive)
;;                                 (term shell-file-name)))
(global-set-key (kbd "C-t") 'shell)


;; C-tでcmd.exeをポップアップ
(require 'shell-pop)
(shell-pop-set-internal-mode "shell")
(defvar ansi-term-after-hook nil)
(add-hook 'ansi-term-after-hook
          '(lambda ()
             (define-key term-raw-map "\C-t" 'shell-pop)))
(defadvice ansi-term (after ansi-term-after-advice (org))
  "run hook as after advice"
  (run-hooks 'ansi-term-after-hook))
(ad-activate 'ansi-term)
(global-set-key "\C-t" 'shell-pop)




)





;;====================
;; Utilities
;;====================

;; install-elispの設定
(require 'install-elisp)

;; インストール場所
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")


;; auto-install
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/elisp/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)


;; auto-insert
;; ファイル形式に応じて自動でテンプレート挿入
;; (add-hook 'find-file-hooks 'auto-insert)
;; (setq auto-insert-directory "~/.emacs.d/templates")
;; (setq auto-insert-alist
;;       '((perl-mode . "perl-template.pl")
;;         (html-mode . "html-template.html")
;;         ("base.css" . "base.css")
;;         (css-mode . "css-template.css")))


;; yasnippet
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")
;(yas/load-directory "~/.emacs.d/elisp/snippets")


;;====================
;; Visual
;;====================

;; color-themeの設定
(require 'color-theme)
(color-theme-initialize)
(color-theme-nishikawasasaki)


;; キーワードのカラー表示を有効化
(global-font-lock-mode t)


;; 選択範囲をハイライト
(setq-default transient-mark-mode t)


;; バッファ一覧をまともに
(global-set-key "\C-x\C-b" 'bs-show)


;; 対応するカッコをハイライト
(show-paren-mode 1)


;; ハイライト
(transient-mark-mode t)


;; ウィンドウを透明化
(add-to-list 'default-frame-alist '(alpha . (0.80 0.80)))


;; 行数表示
(global-set-key "\M-n" 'linum-mode)


(blink-cursor-mode t)





;;====================
;; c-mode(c++)
;;====================

(add-hook 'c-mode-common-hook
          '(lambda ()
             ;; センテンスの終了である ';' を入力したら、自動改行+インデント
             (c-toggle-auto-hungry-state 1)
             ;; RET キーで自動改行+インデント
             (define-key c-mode-base-map "\C-m" 'newline-and-indent)
))


;; C-c c で compile コマンドを呼び出す
(define-key mode-specific-map "c" 'compile)



;;====================
;; Scheme
;;====================

(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))

(setq scheme-program-name "gosh -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)


(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))

;; goshインタプリタのパスに合わせます。-iは対話モードを意味します。
(setq gosh-program-name "/usr/local/bin/gosh -i")

;; schemeモードとrun-schemeモードにcmuscheme.elを使用します。
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)

;; ウィンドウを2つに分け、一方でgoshインタプリタを実行するコマンドを定義します。
(defun scheme-other-window ()
  "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme gosh-program-name))

;; そのコマンドをCtrl-cSで呼び出します。
(define-key global-map
  "\C-cS" 'scheme-other-window)


;; 直前/直後の括弧に対応する括弧を光らせます。
(show-paren-mode t)



;;====================
;; Python
;;====================

;; Python-mode
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("Python" . python-mode)
interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)


;; Pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(eval-after-load "pymacs"
  '(add-to-list 'pymacs-load-path "~/app/emacs/elisp"))


;; 補完
;; (require 'pysmell)
;; (add-hook 'python-mode-hook (lambda () (pysmell-mode 1)))



;;====================
;; scala-mode
;;====================

(add-to-list 'load-path "~/.emacs.d/snippets/scala-mode")
(require 'scala-mode-auto)
    (add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))
(require 'scala-mode-feature-electric)
    (add-hook 'scala-mode-hook
	      (lambda ()
		(scala-electric-mode)))

;; ensime
(add-to-list 'load-path "~/.emacs.d/ensime/elisp/")
    (require 'ensime)
    (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)



;;====================
;; Syntax
;;====================

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



;;====================
;; midi
;;====================

(require 'mi)
(setq mi-use-dls-synth t) ;; OSXの内蔵シンセを使う場合


;; -----------------------------------------------------------
;; auto-complete
;; -----------------------------------------------------------

(require 'auto-complete)
(global-auto-complete-mode t)

(when (require 'auto-complete nil t)
  (global-auto-complete-mode t)
  (define-key ac-complete-mode-map "\C-n" 'ac-next)
  (define-key ac-complete-mode-map "\C-p" 'ac-previous))


;; scheme-mode-hook
(defvar ac-source-scheme
  '((candidates
     . (lambda ()
         (require 'scheme-complete)
         (all-completions ac-target (car (scheme-current-env))))))
  "Source for scheme keywords.")
(add-hook 'scheme-mode-hook
          '(lambda ()
             (make-local-variable 'ac-sources)
             (setq ac-sources (append ac-sources '(ac-source-scheme)))))


;; git用プラグイン magit
(add-to-list 'load-path "~/.emacs.d/elisp/magit/share/emacs/site-lisp/")
(require 'magit)

