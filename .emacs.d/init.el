;; ---------------------------------------------------------------------------------
;; OS Type Defvars
;; ---------------------------------------------------------------------------------

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



;;====================
;; Dired
;;====================
;; dired-x
(require 'dired-x)

;; wdired
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; 並び替えのキー
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



;; C-tでウインドウ分割/移動
;; (defun other-window-or-split ()
;;   (interactive)
;;   (when (one-window-p)
;;     (split-window-horizontally))
;;   (other-window 1))
;; (global-set-key (kbd "C-t") 'other-window-or-split)





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





;----------------------------------
;; etags の追加関数(タグファイルの作成)
;----------------------------------
;; (defadvice find-tag (before c-tag-file activate)
;;   "Automatically create tags file."
;;   (let ((tag-file (concat default-directory "TAGS")))
;;     (unless (file-exists-p tag-file)
;;       (shell-command "etags *.[ch] *.el .*.el -o TAGS 2>/dev/null"))
;;     (visit-tags-table tag-file)))
;; find . -name "*.java" -print | /cygdrive/c/my/programs/emacs/emacs-23.3/bin/etags -


;; ---------------------------------------------------------------------------------
;; OS Settings
;; ---------------------------------------------------------------------------------

;;====================
;; For Mac
;;====================

(when is_mac



    ;; ウィンドウサイズ設定
    (setq initial-frame-alist
          (append (list
             '(width . 140) ;; ウィンドウ幅
               '(height . 60) ;; ウィンドウ高さ
    	       '(top . 500) ;; 表示位置
    	       '(left . 340) ;; 表示位置
               )
              initial-frame-alist))
    (setq default-frame-alist initial-frame-alist)


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
  
  
    ;; exec-pathとPATHに設定したいパスのリストを設定
    (dolist (dir (list
      "/usr/local/bin"
      "/usr/local/scala/bin"
      "~/bin"
	   "/sbin"
	   "/usr/sbin"
	   "/bin"
	   "/usr/bin"
	   (expand-file-name "~/bin")
	   (expand-file-name "~/.emacs.d/bin")
	   ))
    ;; PATH と exec-path に同じ物を追加
    (when (and (file-exists-p dir) (not (member dir exec-path)))
      (setenv "PATH" (concat dir ":" (getenv "PATH")))
      (setq exec-path (append (list dir) exec-path))))
  
  
  
  
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

  
  
     
    ;; ============================================================
    ;; ansi-term
    ;; ============================================================
;(defvar my-shell-pop-key (kbd "C-t"))
;(defvar my-ansi-term-toggle-mode-key (kbd "C-c c"))
; 
;(defadvice ansi-term (after ansi-term-after-advice (arg))
;  "run hook as after advice"
;  (run-hooks 'ansi-term-after-hook))
;(ad-activate 'ansi-term)
; 
;(defun my-term-switch-line-char ()
;  "Switch `term-in-line-mode' and `term-in-char-mode' in `ansi-term'"
;  (interactive)
;  (cond
;   ((term-in-line-mode)
;    (term-char-mode)
;    (hl-line-mode -1))
;   ((term-in-char-mode)
;    (term-line-mode)
;    (hl-line-mode 1))))
; 
;(defadvice anything-c-kill-ring-action (around my-anything-kill-ring-term-advice activate)
;  "In term-mode, use `term-send-raw-string' instead of `insert-for-yank'"
;  (if (eq major-mode 'term-mode)
;      (letf (((symbol-function 'insert-for-yank) (symbol-function 'term-send-raw-string)))
;        ad-do-it)
;    ad-do-it))
; 
;(defvar ansi-term-after-hook nil)
;(add-hook 'ansi-term-after-hook
;          (lambda ()
;            ;; shell-pop
;            (define-key term-raw-map my-shell-pop-key 'shell-pop)
;            ;; M-xできるように
;            (define-key term-raw-map (kbd "M-x") 'nil)
;            ;; コピーと貼り付け
;            (define-key term-raw-map (kbd "C-k")
;              (lambda (&optional arg) (interactive "P") (funcall 'kill-line arg) (term-send-raw)))
;            (define-key term-raw-map (kbd "C-y") 'term-paste)
;            (define-key term-raw-map (kbd "M-y") 'anything-show-kill-ring)
;            ;; F2でline-mode/char-modeを切替
;            (define-key term-raw-map  my-ansi-term-toggle-mode-key 'my-term-switch-line-char)
;            (define-key term-mode-map my-ansi-term-toggle-mode-key 'my-term-switch-line-char)
;))

;; ============================================================
;; shell-pop
;; ============================================================
(require 'shell-pop)
(shell-pop-set-window-height 30)
(shell-pop-set-internal-mode "eshell")
(shell-pop-set-internal-mode-shell shell-file-name)
;(global-set-key my-shell-pop-key 'shell-pop)





    (define-key global-map [?¥] [?\\])  ;; ¥の代わりにバックスラッシュを入力する

)



;====================
; For Win
;====================

(when is_win

    ;; exec-pathとPATHに設定したいパスのリストを設定
    (dolist (dir (list
     	      "C:/scala/scala/bin"
     	      "C:/Python27"
     	      "C:/cygwin/bin"
     	      "C:/Windows/system32/"
     	      "C:/Windows/"
                  (expand-file-name "~/bin")
                  (expand-file-name "~/.emacs.d/bin")
                  ))
    ;; PATH と exec-path に同じ物を追加
    (when (and (file-exists-p dir) (not (member dir exec-path)))
      (setenv "PATH" (concat dir ":" (getenv "PATH")))
      (setq exec-path (append (list dir) exec-path))))
     
    ;; ツールバーを消す
    (tool-bar-mode nil)
   
    ;; ファイル名の文字コード指定
    (setq file-name-coding-system 'shift_jis)


    ;; ウィンドウサイズ設定
    (setq initial-frame-alist
          (append (list
             '(width . 140) ;; ウィンドウ幅
               '(height . 50) ;; ウィンドウ高さ
    	       '(top . 60) ;; 表示位置
    	       '(left . 50) ;; 表示位置
               )
              initial-frame-alist))
    (setq default-frame-alist initial-frame-alist)


   
    ;; フォント設定
    (when window-system
      (set-default-font "VL Gothic:pixelsize=13" t)
      ;; (add-to-list 'default-frame-alist '(font . "VL Gothic:pixelsize=13")) 
      (add-to-list 'default-frame-alist '(font . "MeiryoKe_Console:pixelsize=13"))
      (set-default-coding-systems 'utf-8))
   
    ;; プロクシの設定
    ;; (setq url-proxy-services '(("http" . "192.168.1.8:8080"))) 


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
     
     
    ;; shellでzshを使う(指定しない場合はcmd.exe)
    ;; (setq explicit-shell-file-name "c:\\cygwin\\bin\\zsh.exe")
     
    ;; C-tでcmd.exeをポップアップ
    (require 'shell-pop)
    (shell-pop-set-internal-mode "shell") ;; shellを使う
    ;;(shell-pop-set-internal-mode "ansi-term") ;; ansi-termを使う
    ;;(shell-pop-set-internal-mode-shell "c:\\cygwin\\bin\\zsh.exe")
    (defvar ansi-term-after-hook nil)
    (add-hook 'ansi-term-after-hook
              '(lambda ()
                 (define-key term-raw-map "\C-t" 'shell-pop)))
    (defadvice ansi-term (after ansi-term-after-advice (org))
      "run hook as after advice"
      (run-hooks 'ansi-term-after-hook))
    (ad-activate 'ansi-term)
    (global-set-key "\C-t" 'shell-pop)
     
     
     
     
    ;; Twittering-modeのプロクシ
    ;; (setq twittering-proxy-use t)
    ;; (setq twittering-proxy-server "192.168.1.8")
    ;; (setq twittering-proxy-port 8080)
     
     
    ;; IMEの制御（yes/noをタイプするところでは IME をオフにする）
    (wrap-function-to-control-ime 'universal-argument t nil)
    (wrap-function-to-control-ime 'read-string nil nil)
    (wrap-function-to-control-ime 'read-char nil nil)
    (wrap-function-to-control-ime 'read-from-minibuffer nil nil)
    (wrap-function-to-control-ime 'y-or-n-p nil nil)
    (wrap-function-to-control-ime 'yes-or-no-p nil nil)
    (wrap-function-to-control-ime 'map-y-or-n-p nil nil)
    (eval-after-load "ange-ftp"
      '(wrap-function-to-control-ime 'ange-ftp-get-passwd nil nil)
    )





)







;; ---------------------------------------------------------------------------------
;; Mode Settings 
;; ---------------------------------------------------------------------------------

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
;; (add-to-list 'load-path "~/.emacs.d/ensime/elisp/")
;; (require 'ensime)
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)







;; ---------------------------------------------------------------------------------
;; elisp Settings
;; ---------------------------------------------------------------------------------

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


;;====================
;; ElScreen
;;====================
;; EmacsでGNU screen風のインターフェイスを使う
(setq elscreen-prefix-key "\C-z")
(require 'elscreen)
(if window-system
    (define-key elscreen-map "\C-z" 'iconify-or-deiconify-frame)
  (define-key elscreen-map "\C-z" 'suspend-emacs))

;; 以下は自動でスクリーンを生成する場合の設定
(defmacro elscreen-create-automatically (ad-do-it)
  `(if (not (elscreen-one-screen-p))
       ,ad-do-it
     (elscreen-create)
     (elscreen-notify-screen-modification 'force-immediately)
     (elscreen-message "New screen is automatically created")))

(defadvice elscreen-next (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

(defadvice elscreen-previous (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

(defadvice elscreen-toggle (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))
     
(setq elscreen-display-tab 10) ; タブの幅（６以上じゃないとダメ）
(setq elscreen-tab-display-kill-screen nil) ; タブの左端の×を非表示

(global-set-key (kbd "C-z C-c") 'elscreen-clone) ; 今のウインドウを基に作成
(global-set-key (kbd "C-z C-k") 'elscreen-kill-screen-and-buffers) ; スクリーンとバッファをkill
(global-set-key [(C-tab)] 'elscreen-next) ; ブラウザみたいに
(global-set-key [(C-S-tab)] 'elscreen-previous) ; ブラウザみたいに　その2

;; elscreen-server
(require 'elscreen-server)

;; elscreen-dired
(require 'elscreen-dired)

;; elscreen-color-theme
(require 'elscreen-color-theme)



;;====================
;; color-moccur
;;====================
(require 'color-moccur)
(setq moccur-split-word t)

;; migemoがrequireできる環境ならmigemoを使う
;; (when (require 'migemo nil t) ;第三引数がnon-nilだとloadできなかった場合にエラーではなくnilを返す
;; (setq moccur-use-migemo t))

;; (global-set-key (kbd "M-o") 'occur-by-moccur)
;; (global-set-key (kbd "C-M-o") 'moccur-grep-find)


;;====================
;; moccur-edit
;;====================
(require 'moccur-edit)
(setq moccur-split-word t)


;;====================
;; magit
;;====================
;; git用プラグイン magit
(add-to-list 'load-path "~/.emacs.d/elisp/magit/share/emacs/site-lisp/")
(require 'magit)







;;====================
;; auto-complete
;;====================
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq ac-dwim t)
;; ;; 辞書ファイルの位置
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")

;; デフォルト設定有効
;;(ac-config-default)

;; 自動補完
(setq ac-auto-start 2) ; 2文字以上で補完開始
;; 手動補完するならこっち
;; (setq ac-auto-start nil) ; 自動的に開始しない

;; コンテキストに応じてTABで補完
(ac-set-trigger-key "TAB") 
;; ;で補完確定
(define-key ac-complete-mode-map "RET" 'ac-complete)
;; 候補選択
(define-key ac-complete-mode-map "\C-n" 'ac-next-or-next-line)
(define-key ac-complete-mode-map "\C-p" 'ac-previous-or-previous-line)

;; 補完の情報源
;; (setq-default ac-sources '(ac-source-words-in-same-mode-buffers ac-source-filename ac-source-symbols)) 
;; 補完するモードの追加
(setq ac-modes (append ac-modes '(text-mode sql-mode scala-mode)))

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




;;====================
;; smooth-scroll
;;====================
(require 'smooth-scroll)
(smooth-scroll-mode t)

;; smooth scroll of the buffer
(set-variable 'smooth-scroll/vscroll-step-size 8)
(set-variable 'smooth-scroll/hscroll-step-size 8)
;; (setq scroll-step 1
;; scroll-conservatively 10000)


;;====================
;; anything
;;====================
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


;;; anything-c-moccurの設定
(require 'anything-c-moccur)
;; カスタマイズ可能変数の設定(M-x customize-group anything-c-moccur でも設定可能)
(setq anything-c-moccur-anything-idle-delay 0.2 ;`anything-idle-delay'
      anything-c-moccur-higligt-info-line-flag t ; `anything-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
      anything-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示する
      anything-c-moccur-enable-initial-pattern t ; `anything-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする
;      anything-c-moccur-use-moccur-anything-map-flag nil ; non-nilならanything-c-moccurのデフォルトのキーバインドを使用する
      )

;;; キーバインドの割当(好みに合わせて設定してください)
(global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur) ;バッファ内検索
(global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur) ;ディレクトリ
(add-hook 'dired-mode-hook ;dired
          '(lambda ()
             (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))



;;====================
;; cua
;;====================
;; 矩形処理にcuaを利用
(cua-mode t)
;; 矩形以外のcuaの機能をオフ
(setq cua-enable-cua-keys nil) 




;;====================
;; popwin
;;====================
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
;; anythingをpopwinで行うため
(setq anything-samewindow nil)
;; popwinを使う表示を設定
(setq popwin:special-display-config
      (append '(("*Remember*" :stick t)
		("*Backtrace*")
		("*Messages*")
		("*Compile-Log*")
                ("*sdic*" :noselect t)
		("*anything*" :height 20)
;		("*Moccur*" :height 20)
		("*Directory*" :height 20)
		("*undo-tree*" :height 20)
	       )
              popwin:special-display-config))
;; 最後に表示したpopwinを再表示
(define-key global-map (kbd "C-x p") 'popwin:display-last-buffer)



;;====================
;; undo-tree
;;====================
;; undo redoを木構造で保存
(require 'undo-tree)
(global-undo-tree-mode)
(global-set-key (kbd "M-/") 'undo-tree-redo)


;;====================
;; thing-opt
;;====================
;; テキストオブジェクト(thing)選択
(require 'thing-opt)
(define-thing-commands)
(global-set-key (kbd "C-$") 'mark-word*) ; 単語を選択
(global-set-key (kbd "C-\"") 'mark-string) ; 文字列(""含む)を選択
(global-set-key (kbd "C-(") 'mark-up-list) ; リスト表記()を選択



;;====================
;; Keycord
;;====================
;; Keycordの設定
(require 'key-chord)
(key-chord-mode 1)
(setq key-chord-one-keys-delay 0.04)

;; don't hijack input method!
(defadvice toggle-input-method (around toggle-input-method-around activate)
  (let ((input-method-function-save input-method-function))
    ad-do-it
    (setq input-method-function input-method-function-save)))
(key-chord-define-global "YY" 'copy-line)
(key-chord-define-global "VV" 'mark-line)
(key-chord-define-global "DD" 'kill-whole-line)
(key-chord-define-global "mk" 'kill-buffer)
(key-chord-define-global "cv" 'scroll-up)
(key-chord-define-global "vb" 'scroll-down)
(key-chord-define-global "MM" 'occur-by-moccur)

(key-chord-define-global "ql" 'windmove-right)
(key-chord-define-global "qh" 'windmove-left)
(key-chord-define-global "qj" 'windmove-down)
(key-chord-define-global "qk" 'windmove-up)




;;====================
;; uniquify
;;====================
;; 同一名の buffer があったとき、開いているファイルのパスの一部を表示して区別する
(when (locate-library "uniquify")
  (require 'uniquify)
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets))



;;====================
;; savekill
;;====================
;; kill ringの中身をファイル保存
(require 'savekill)


;;====================
;; jaunte
;;====================
;; vimperatorのhit a hint風
(require 'jaunte)
(global-set-key (kbd "C-c C-j") 'jaunte)


;;====================
;; howm
;;====================
;; メモを取ろう！！
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
(mapc
 (lambda (f)
   (autoload f
     "howm" "Hitori Otegaru Wiki Modoki" t))
 '(howm-menu howm-list-all howm-list-recent
             howm-list-grep howm-create
             howm-keyword-to-kill-ring))

;; リンクを TAB で辿る
(eval-after-load "howm-mode"
  '(progn
     (define-key howm-mode-map [tab] 'action-lock-goto-next-link)
     (define-key howm-mode-map [(meta tab)] 'action-lock-goto-previous-link)))
;; 「最近のメモ」一覧時にタイトル表示
(setq howm-list-recent-title t)
;; 全メモ一覧時にタイトル表示
(setq howm-list-all-title t)
;; メニューを 2 時間キャッシュ
(setq howm-menu-expiry-hours 2)

;; howm の時は auto-fill で
(add-hook 'howm-mode-on-hook 'auto-fill-mode)

;; RET でファイルを開く際, 一覧バッファを消す
;; C-u RET なら残る
(setq howm-view-summary-persistent nil)

;; メニューの予定表の表示範囲
;; 10 日前から
(setq howm-menu-schedule-days-before 10)
;; 3 日後まで
(setq howm-menu-schedule-days 3)

;; howm のファイル名
;; 以下のスタイルのうちどれかを選んでください
;; で，不要な行は削除してください
;; 1 メモ 1 ファイル (デフォルト)
(setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.howm")
;; 1 日 1 ファイルであれば
;; (setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm")

(setq howm-view-grep-parse-line
      "^\\(\\([a-zA-Z]:/\\)?[^:]*\\.howm\\):\\([0-9]*\\):\\(.*\\)$")
;; 検索しないファイルの正規表現
(setq
 howm-excluded-file-regexp
 "/\\.#\\|[~#]$\\|\\.bak$\\|/CVS/\\|\\.doc$\\|\\.pdf$\\|\\.ppt$\\|\\.xls$")

;; いちいち消すのも面倒なので
;; 内容が 0 ならファイルごと削除する
(if (not (memq 'delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
          (cons 'delete-file-if-no-contents after-save-hook)))
(defun delete-file-if-no-contents ()
  (when (and
         (buffer-file-name (current-buffer))
         (string-match "\\.howm" (buffer-file-name (current-buffer)))
         (= (point-min) (point-max)))
    (delete-file
     (buffer-file-name (current-buffer)))))

;; http://howm.sourceforge.jp/cgi-bin/hiki/hiki.cgi?SaveAndKillBuffer
;; C-cC-c で保存してバッファをキルする
(defun my-save-and-kill-buffer ()
  (interactive)
  (when (and
         (buffer-file-name)
         (string-match "\\.howm"
                       (buffer-file-name)))
    (save-buffer)
    (kill-buffer nil)))
(eval-after-load "howm"
  '(progn
     (define-key howm-mode-map
       "\C-c\C-c" 'my-save-and-kill-buffer)))



;;====================
;; twittering-mode
;;====================
;; twittering-mode twittering-numbering.el
;; https://github.com/pft/elisp-assorted/blob/master/twittering-numbering.el
;; twittering-mode
(require 'twittering-mode)
(autoload 'twittering-numbering "twittering-numbering" t)
(add-hook 'twittering-mode-hook 'twittering-numbering)
(setq twittering-use-master-password t)
(setq twittering-status-format "%i %S(%s)  %@:\n  %t // from %f%L %p \n\n")
;; %s - screen_name
;; %S - name
;; %i - profile_image
;; %d - description
;; %l - location
;; %L - " [location]"
;; %u - url
;; %j - user.id
;; %p - protected?
;; %c - created_at (raw UTC string)
;; %C{time-format-str} - created_at (formatted with time-format-str)
;; %@ - X seconds ago
;; %t - text
;; %' - truncated
;; %f - source
;; %# - id






;;====================
;; keisen-mule
;;====================
;; 罫線を簡単に引くモード
;; srefをarefに置き換えて動かすための設定(ソースを修正したためコメントアウト)
;; (unless (fboundp 'sref) (defalias 'sref 'aref))
(if window-system
    (autoload 'keisen-mode "keisen-mouse" "MULE 版罫線モード + マウス" t)
  (autoload 'keisen-mode "keisen-mule" "MULE 版罫線モード" t))


;;====================
;; Eshell
;;====================
;; emacs起動時にeshell起動
(add-hook 'after-init-hook
          (lambda()
            (eshell)
            (switch-to-buffer "*scratch*")))

;; 補完時に大文字小文字を区別しない
(setq eshell-cmpl-ignore-case t)
;; 確認なしでヒストリ保存
(setq eshell-ask-to-save-history (quote always))
;; 補完時にサイクルする
(setq eshell-cmpl-cycle-completions t)
;;(setq eshell-cmpl-cycle-completions nil)
;;補完候補がこの数値以下だとサイクルせずに候補表示
;(setq eshell-cmpl-cycle-cutoff-length 5)
;; 履歴で重複を無視する
(setq eshell-hist-ignoredups t)
;; prompt 文字列の変更
(defun my-eshell-prompt ()
(concat (eshell/pwd) "\n♪ " ))
(setq eshell-prompt-function 'my-eshell-prompt)
(setq eshell-prompt-regexp "^[^#$\n]*[#→] ")

;; sudoのあとも補完可能に
(defun pcomplete/sudo ()
  "Completion rules for the `sudo' command."
  (let ((pcomplete-help "complete after sudo"))
    (pcomplete-here (pcomplete-here (eshell-complete-commands-list)))))

;; トグルする設定
(defun my-toggle-term ()
  "eshell と直前のバッファを行き来する。C-u 付きで呼ぶと 今いるバッファと同じディレクトリに cd して開く"
  (interactive)
  (let ((ignore-list '("*Help*" "*Minibuf-1*" "*Messages*" "*Completions*"
                       "*terminal<1>*" "*terminal<2>*" "*terminal<3>*"))
        (dir default-directory))
    (labels
        ((_my-toggle-term (target)
           (if (null (member (buffer-name (second target)) ignore-list))
               (if (equal "*eshell*" (buffer-name (window-buffer)))
                   (switch-to-buffer (second target))
                 (switch-to-buffer "*eshell*")
                 (when current-prefix-arg
                   (cd dir)
                   (eshell-interactive-print (concat "cd " dir "\n"))
                   (eshell-emit-prompt)))
             (_my-toggle-term (cdr target)))))
      (_my-toggle-term (buffer-list)))))
(global-set-key (kbd "C-t") 'my-toggle-term)

;; eshell での補完に auto-complete.el を使う
(require 'pcomplete)
(add-to-list 'ac-modes 'eshell-mode)
(ac-define-source pcomplete
  '((candidates . pcomplete-completions)))
(defun my-ac-eshell-mode ()
  (setq ac-sources
        '(ac-source-pcomplete
          ac-source-words-in-buffer
          ac-source-dictionary)))
(add-hook 'eshell-mode-hook
          (lambda ()
            (my-ac-eshell-mode)
            (define-key eshell-mode-map (kbd "C-i") 'auto-complete)))

;; キーバインドの変更
(add-hook 'eshell-mode-hook
          '(lambda ()
             (progn
               (define-key eshell-mode-map (kbd "C-a") 'eshell-bol)
               (define-key eshell-mode-map [up] 'eshell-previous-matching-input-from-input)
               (define-key eshell-mode-map [down] 'eshell-next-matching-input-from-input)
               (define-key eshell-mode-map (kbd "C-p") 'previous-line)
               (define-key eshell-mode-map (kbd "C-n") 'next-line)
               )
             ))

;; エスケープシーケンスを処理
;; http://d.hatena.ne.jp/hiboma/20061031/1162277851
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
          "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'eshell-load-hook 'ansi-color-for-comint-mode-on)

;; http://www.emacswiki.org/emacs-ja/EshellColor
(require 'ansi-color)
(require 'eshell)
(defun eshell-handle-ansi-color ()
  (ansi-color-apply-on-region eshell-last-output-start
                              eshell-last-output-end))
(add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)

;; aliasの設定
(eval-after-load "em-alias"
  '(progn (eshell/alias "ll" "ls -alhF")))





;; ---------------------------------------------------------------------------------
;; Visual Settings 
;; ---------------------------------------------------------------------------------

;; color-themeの設定
(require 'color-theme)
(color-theme-initialize)
;;(color-theme-nishikawasasaki)
(color-theme-tangotango)


;; キーワードのカラー表示を有効化
(global-font-lock-mode t)


;; 選択範囲をハイライト
(setq-default transient-mark-mode t)


;; モードライン (mode-line-format)での書式記号
;; %b -- print buffer name.      
;; %f -- print visited file name.
;; %F -- print frame name.
;; %* -- print %, * or hyphen.   
;; %+ -- print *, % or hyphen.
;;       %& is like %*, but ignore read-only-ness.
;;       % means buffer is read-only and * means it is modified.
;;       For a modified read-only buffer, %* gives % and %+ gives *.
;; %s -- print process status.   %l -- print the current line number.
;; %c -- print the current column number (this makes editing slower).
;;       To make the column number update correctly in all cases,`column-number-mode' must be non-nil.
;; %i -- print the size of the buffer.
;; %I -- like %i, but use k, M, G, etc., to abbreviate.
;; %p -- print percent of buffer above top of window, or Top, Bot or All.
;; %P -- print percent of buffer above bottom of window, perhaps plus Top, or print Bottom or All.
;; %n -- print Narrow if appropriate.
;; %t -- visited file is text or binary (if OS supports this distinction).
;; %z -- print mnemonics of keyboard, terminal, and buffer coding systems.
;; %Z -- like %z, but including the end-of-line format.
;; %e -- print error message about full memory.
;; %@ -- print @ or hyphen.  @ means that default-directory is on a remote machine.
;; %[ -- print one [ for each recursive editing level.  %] similar.
;; %% -- print %.   
;; %- -- print infinitely many dashes.	
;; モードライン
(setq-default mode-line-format 
  (list "%*["
	'mode-line-mule-info
	"] L%l:C%c %P   %b   (%m"
	'minor-mode-alist
	")"
  )
)

;; タイトルバー
(setq frame-title-format (format "%%f - Emacs@%s" (system-name)))


;; 対応するカッコをハイライト
(show-paren-mode 1)


;; ハイライト
(transient-mark-mode t)


;; ウィンドウを透明化
(add-to-list 'default-frame-alist '(alpha . (0.80 0.80)))


;; 行数表示
(global-set-key "\M-n" 'linum-mode)

;; カーソル点滅
(blink-cursor-mode t)



;; カーソル行ハイライト
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "gray15"))
    (((class color)
      (background light))
     (:background "ForestGreen"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
;; (setq hl-line-face 'underline) ; 下線
(global-hl-line-mode)


;; 1画面スクロールで前の表示を何行分残すか
(setq next-screen-context-lines 5)
