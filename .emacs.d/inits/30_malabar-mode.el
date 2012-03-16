;;====================
;; malabar-mode
;;====================
(add-to-list 'load-path "~/.emacs.d/elisp/malabar-1.5-SNAPSHOT/lisp")

(require 'cedet)
(setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
                                  global-semanticdb-minor-mode
                                  global-semantic-idle-summary-mode
                                  global-semantic-mru-bookmark-mode))
(semantic-mode 1)

(require 'malabar-mode)
(setq malabar-groovy-lib-dir "~/.emacs.d/elisp/malabar-1.5-SNAPSHOT/lib")
(add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))

;; 普段使わないパッケージを import 候補から除外
(add-to-list 'malabar-import-excluded-classes-regexp-list
             "^java\\.awt\\..*$")
(add-to-list 'malabar-import-excluded-classes-regexp-list
             "^com\\.sun\\..*$")
(add-to-list 'malabar-import-excluded-classes-regexp-list
             "^org\\.omg\\..*$")

;; コンパイル前に保存する
(add-hook 'malabar-mode-hook
          (lambda ()
            (add-hook 'after-save-hook 'malabar-compile-file-silently nil t)))
; 日本語だとコンパイルエラーメッセージが化けるので
(setq malabar-groovy-java-options '("-Duser.language=en")) 
