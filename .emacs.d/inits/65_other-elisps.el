;;====================
;; smooth-scroll
;;====================
(require 'smooth-scroll)
(smooth-scroll-mode t)

;; smooth scroll of the buffer
(set-variable 'smooth-scroll/vscroll-step-size 3)
(set-variable 'smooth-scroll/hscroll-step-size 3)


;;====================
;; cua
;;====================
;; 矩形選択開始キーの変更
(setq cua-rectangle-mark-key (kbd "C-S-<return>"))
;; 矩形処理にcuaを利用
(cua-mode t)
;; 矩形以外のcuaの機能をオフ
(setq cua-enable-cua-keys nil)


;;====================
;; uniquify
;;====================
;; 同一名の buffer があったとき、開いているファイルのパスの一部を表示して区別する
(require 'uniquify)
;; (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-strip-common-suffix nil)


;;====================
;; savekill
;;====================
;; kill ringの中身をファイル保存
;; (require 'savekill) ; Windows で定期的に重たくなるためコメントアウト



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
;; slime
;;====================
;; Clozure CLをデフォルトのCommon Lisp処理系に設定

(when is_win
  (setq inferior-lisp-program "ccl.bat"))
(when is_mac
  (setq inferior-lisp-program "ccl"))
(when is_linux
  (setq inferior-lisp-program "ccl"))


;; ~/.emacs.d/slimeをload-pathに追加
(add-to-list 'load-path (expand-file-name "~/.emacs.d/slime"))
;; SLIMEのロード
(require 'slime)
(slime-setup '(slime-repl slime-fancy slime-banner))
;; SLIMEからの入力をUTF-8に設定
(setq slime-net-coding-system 'utf-8-unix)

;; slime キーバインドを設定
(add-hook 'slime-mode-hook
          '(lambda ()
             (define-key slime-mode-map [(tab)]     'slime-indent-and-complete-symbol)))

;; slime-repl再起動
(add-hook 'slime-repl-mode-hook
          '(lambda ()
             (define-key slime-repl-mode-map "\C-c\M-r" 'slime-restart-inferior-lisp)))



;;====================
;; cyg-mount
;;====================
;; Cygwin のドライブ・プレフィックスを有効に
(when is_win
  (setq cygwin-mount-cygwin-bin-directory "c:/cygwin/bin")
  (require 'cygwin-mount)
  (cygwin-mount-activate)
  )


;;====================
;; rst
;;====================
;; @see launch setting
(require 'rst)
;; 拡張子の*.rst, *.restのファイルをrst-modeで開く
(setq auto-mode-alist
      (append '(("\\.rst$" . rst-mode)
                ;;("\\.howm$" . rst-mode)
                ("\\.rest$" . rst-mode)) auto-mode-alist))
;; 背景が黒い場合はこうしないと見出しが見づらい
(setq frame-background-mode 'dark)
;; インデントをスペースで
(add-hook 'rst-mode-hook
          '(lambda()
             (setq indent-tabs-mode nil)
             ;;       (setq-default tab-width 3 indent-tabs-mode nil)
             ))



;;====================
;; gtags
;;====================
(when (locate-library "gtags")
  (require 'gtags)
  ; (require 'anything-gtags)
  ; (global-set-key (kbd "C-q w") 'anything-gtags-select)
  )

(global-set-key "\M-t" 'gtags-find-tag)     ;関数の定義元へ
(global-set-key "\M-r" 'gtags-find-rtag)    ;関数の参照先へ
(global-set-key "\M-s" 'gtags-find-symbol)  ;変数の定義元/参照先へ
(global-set-key "\M-p" 'gtags-find-pattern)
;;(global-set-key "\M-f" 'gtags-find-file)    ;ファイルにジャンプ
(global-set-key [?\C-,] 'gtags-pop-stack)   ;前のバッファに戻る

(setq gtags-mode-hook
      '(lambda ()
         (setq gtags-select-buffer-single t)
         ))


;;====================
;; smartchr.el
;;====================
(require 'smartchr)
(global-set-key (kbd ">")
                (smartchr '(">" ">>" "-> " "=> " "-> '`!!''" "-> \"`!!'\"" "=> '`!!''" "=> \"`!!'\"" "")))
(global-set-key (kbd "\"") (smartchr '("\"" "\"`!!'\"" "'" "'`!!''" "")))
;; (global-set-key (kbd "(") (smartchr '("(" "(`!!')" "((" "")))
(global-set-key (kbd "G") (smartchr '("G" "ありがとうございます" "`!!'ありがとうございます" "")))



;;====================
;; popup-select-window.el
;;====================
(require 'popup)
(require 'popup-select-window)
(global-set-key "\C-xo" 'popup-select-window)
(key-chord-define-global "gh" 'popup-select-window)
(key-chord-define-global "qw" 'popup-select-window)
;; モードラインハイライトをオフ
(setq popup-select-window-use-modeline-highlight nil)



;;====================
;; htmlize.el
;;====================
(load "htmlize.el")


;;====================
;; revive.el
;;====================
;; http://www.hasta-pronto.org/archives/2008/01/30-0235.php
(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe emacs" t)
(add-hook 'kill-emacs-hook 'save-current-configuration)   ; 終了時に保存
;; 起動時に復元しないバッファ名を正規表現で指定
(setq revive:ignore-buffer-pattern "\\.loaddefs\\.el")
(resume) ; 起動時に復元

;; フレームの状態を保存
(require 'revive+)
(revive-plus:demo)
(setq revive-plus:all-frames t)
(define-key global-map (kbd "C-c r s") 'revive-plus:wconf-archive-save)
(define-key global-map (kbd "C-c r r") 'revive-plus:wconf-archive-restore)


;;====================
;; save-frame-posize.el
;;====================
(require 'save-frame-posize)




;;====================
;; migemo.el
;;====================
(setq migemo-command "cmigemo")
;; (setq migemo-options '("-q" "--emacs" "-i" "\a"))
(setq migemo-options '("-q" "--emacs"))
(setq migemo-dictionary (expand-file-name "~/.emacs.d/elisp/migemo/migemo-dict"))
;; (setq migemo-accept-process-output-timeout-msec 80)
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-use-pattern-alist t)
(setq migemo-use-frequent-pattern-alist t)
(setq migemo-pattern-alist-length 1024)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)


;;====================
;; emacs-historyf
;;====================
(require 'historyf)
(define-key global-map (kbd "C-q l") 'historyf-forward)
(define-key global-map (kbd "C-q h") 'historyf-back)
(key-chord-define-global "bn" 'historyf-forward)
(key-chord-define-global "bp" 'historyf-back)



;;====================
;; dsvn.el
;;====================
(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)




;;====================
;; others
;;====================
(require 'recentf-ext)


;; point-undo
(require 'point-undo)
(define-key global-map (kbd "<f7>") 'point-undo)
(define-key global-map (kbd "C-q b") 'point-undo)
(define-key global-map (kbd "S-<f7>") 'point-redo)
(define-key global-map (kbd "C-q f") 'point-redo)


;; 最後の変更箇所にジャンプ
(require 'goto-chg)
(define-key global-map (kbd "<f8>") 'goto-last-change)
(define-key global-map (kbd "S-<f8>") 'goto-last-change-reverse)
