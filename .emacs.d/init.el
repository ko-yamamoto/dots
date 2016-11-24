;; (setq debug-on-error t)
(setq gc-cons-threshold (* 128 1024 1024))

;; load-path 追加
(setq load-path
      (append
       (list
        ;; (expand-file-name "~/.emacs.d/")
        (expand-file-name "~/.emacs.d/elisp/"))
       load-path))

;; package の初期化 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(setq package-enable-at-startup nil)
;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)


;; use-package  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (require 'use-package nil t)
  (message "Use-package is unavailable!")
  (defmacro use-package (&rest _args)))

;; elscreen-persist で起動時にエラーの起きるのでワークアラウンド
(let ((elscreen-persist-file "~/.emacs.d/elscreen"))
  (when (file-writable-p elscreen-persist-file)
    (with-temp-buffer (insert-file-contents-literally elscreen-persist-file)
                      (replace-string "#<" "<")
                      (write-region (point-min) (point-max) elscreen-persist-file))))


;; 起動処理
;; init.el の分割
(use-package init-loader
  :pin melpa
  :ensure t
  :config
  (setq init-loader-byte-compile t) ; 起動時にコンパイル
  (init-loader-load "~/.emacs.d/inits") ; 設定ファイルがあるディレクトリを指定
  )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(org-trello-current-prefix-keybinding "C-c o" nil (org-trello))
 '(org-trello-files (quote ("~/memo/trello-work.org")) nil (org-trello))
 '(package-selected-packages
   (quote
    (twittering-mode org-trello ox-gfm helm-ag aggressive-indent zzz-to-char zlc yalinum wrap-region wgrep-ag web-mode volatile-highlights use-package undo-tree smartrep smart-newline smart-mark slime shackle scratch-log scala-mode2 recentf-ext powerline polymode point-undo multiple-cursors moccur-edit migemo markdown-mode magit key-chord js2-mode isearch-dabbrev init-loader imenu-anywhere hl-line+ highlight-symbol helm-descbinds goto-chg git-gutter-fringe+ fuzzy flycheck-pos-tip expand-region elscreen-persist drag-stuff ddskk company-try-hard company-statistics clojure-mode-extra-font-locking buffer-move anzu ag ac-cider))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
