;;====================
;; auto-async-byte-compile
;;====================
(require 'auto-async-byte-compile)
;; オートコンパイル無効にする正規表現
(setq auto-async-byte-compile-exclude-file-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)


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
;; cua
;;====================
;; 矩形処理にcuaを利用
(cua-mode t)
;; 矩形以外のcuaの機能をオフ
(setq cua-enable-cua-keys nil) 


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
  (setq inferior-lisp-program "dx86cl64"))
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
;; ac-sime
;;====================
(require 'ac-slime)
(add-hook 'slime-mode-hook      'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
                           (auto-complete-mode 1))))
(real-global-auto-complete-mode t)


;;====================
;; cl-indent-patches
;;====================
(when (require 'cl-indent-patches nil t)
  ;; emacs-lispのインデントと混同しないように
  (setq lisp-indent-function
        (lambda (&rest args)
          (apply (if (memq major-mode '(emacs-lisp-mode lisp-interaction-mode))
                     'lisp-indent-function
                   'common-lisp-indent-function)
                 args))))


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
                ("\\.howm$" . rst-mode)
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
 (smartchr '(">" "-> " "=> " "-> '`!!''" "-> \"`!!'\"" "=> '`!!''" "=> \"`!!'\"" "")))
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



(when is_not_win
  ;;====================
  ;; emacs-evernote-mode
  ;;====================
  ;; (add-to-list 'load-path "<your load path>")
  (require 'evernote-mode)
  (setq evernote-username "momijishimeji") ; optional: you can use this username as default.
  ;; (setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8")) ; optional
  (global-set-key "\C-cec" 'evernote-create-note)
  (global-set-key "\C-ceo" 'evernote-open-note)
  (global-set-key "\C-ces" 'evernote-search-notes)
  (global-set-key "\C-ceS" 'evernote-do-saved-search)
  (global-set-key "\C-cew" 'evernote-write-note)
  (global-set-key "\C-cep" 'evernote-post-region)
  (global-set-key "\C-ceb" 'evernote-browser))


;;====================
;; malabar-mode
;;====================
;; (require 'malabar-mode nil t)
;; (setq malabar-groovy-lib-dir (expand-file-name "~/.emacs.d/elisp/malabar-1.5/malabar-lib")) ; お好みで
;; (add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))

;; ;; 普段使わないパッケージを import 候補から除外
;; (add-to-list 'malabar-import-excluded-classes-regexp-list
;;              "^java\\.awt\\..*$")
;; (add-to-list 'malabar-import-excluded-classes-regexp-list
;;              "^com\\.sun\\..*$")
;; (add-to-list 'malabar-import-excluded-classes-regexp-list
;;              "^org\\.omg\\..*$")

;; ;; コンパイル前に保存する
;; (add-hook 'malabar-mode-hook
;;           (lambda ()
;;             (add-hook 'after-save-hook 'malabar-compile-file-silently nil t)))
;; ; 日本語だとコンパイルエラーメッセージが化けるので
;; (setq malabar-groovy-java-options '("-Duser.language=en")) 


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
(resume) ; 起動時に復元


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
