(when is_emacs24

  ;;====================
  ;; el-get
  ;;====================
  (add-to-list 'load-path "~/.emacs.d/el-get/el-get")


  (unless (require 'el-get nil t)
    (url-retrieve
     "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
     (lambda (s)
       (let (el-get-master-branch)
         (goto-char (point-max))
         (eval-print-last-sexp)))))
  ;; (require 'el-get)

  (setq el-get-sources
        '(

          ; (:name anything
                 ; :after (progn
                          ; (setq
                           ; ;; ショートカットアルファベット表示
                           ; ;; anything-enable-shortcuts 'alphabet
                           ; ;; 候補表示までの時間
                           ; anything-idle-delay 0.3
                           ; ;; 候補の多いときに体感速度を上げる
                           ; anything-quick-update t
                           ; )

                          ; (require 'anything-config)

                          ; ;; persistent-action を buffer kill に入れ替えたものソース
                          ; (defvar anything-c-source-buffers-list-R
                            ; `((name . "Buffers")
                              ; (candidates . anything-c-buffer-list)
                              ; (type . buffer)
                              ; (match anything-c-buffer-match-major-mode)
                              ; (candidate-transformer anything-c-skip-boring-buffers
                                                     ; anything-c-highlight-buffers)
                              ; (persistent-action . anything-c-buffers-list-R-persistent-action)
                              ; (keymap . ,anything-c-buffer-map)
                              ; (volatile)
                              ; (mode-line . anything-buffer-mode-line-string)
                              ; (persistent-help . "Kill this buffer / C-u \\[anything-execute-persistent-action]:Show this buffer ")))
                          ; (defun anything-c-buffers-list-R-persistent-action (candidate)
                            ; (if current-prefix-arg
                                ; (anything-c-switch-to-buffer candidate)
                              ; (anything-c-buffers-persistent-kill candidate)))

                          ; ;; anything で欲しい物全部表示版
                          ; (defun my-anything-all ()
                            ; (interactive)
                            ; (anything-other-buffer
                             ; '(
                               ; ;; anything-c-source-buffers+
                               ; ;; anything-c-source-buffers+-howm-title
                               ; anything-c-source-buffers-list-R
                               ; anything-c-source-elscreen
                               ; anything-c-source-recentf
                               ; anything-c-source-etags-select
                               ; anything-c-source-ctags
                               ; anything-c-source-gtags-select
                               ; anything-c-source-imenu
                               ; anything-c-source-emacs-commands
                               ; anything-c-source-emacs-functions
                               ; anything-c-source-files-in-current-dir)
                             ; "*my-anything-all*"))
                          ; (define-key global-map (kbd "C-;") 'my-anything-all)
                          ; ;; anything でバッファと elscreen 表示
                          ; (defun my-anything-buf-screens ()
                            ; (interactive)
                            ; (anything-other-buffer
                             ; '(
                               ; ;; anything-c-source-buffers+
                               ; ;; anything-c-source-buffers+-howm-title
                               ; anything-c-source-buffers-list-R
                               ; anything-c-source-elscreen)
                             ; "*my-anything-buf-screens*"))
                          ; (define-key global-map (kbd "C-x C-b") 'my-anything-buf-screens)

                          ; (defun anything-my-semantic-imenu ()
                            ; (interactive)
                            ; (anything-other-buffer
                             ; '(anything-c-source-imenu)
                             ; "*anything-my-imenu*"))
                          ; (define-key global-map (kbd "C-q i") 'anything-my-semantic-imenu)

                          ; (defun anything-with-new-elscreen ()
                            ; "新しい elscreen で anything"
                            ; (interactive)
                            ; (elscreen-create)
                            ; (my-anything-all))
                          ; (define-key global-map (kbd "C-:") 'anything-with-new-elscreen)

                          ; ;; kill-ringもanythigで
                          ; (global-set-key (kbd "M-y") 'anything-show-kill-ring)

                          ; ;; C-d でバッファを消せるように
                          ; (define-key anything-map (kbd "C-d") 'anything-buffer-run-kill-buffers)

                          ; ))

          (:name helm-github
                 :type github
                 :url "git://github.com/emacs-helm/helm.git"
                 :after (progn


                          (require 'helm-config)

                          (helm-mode 1)

                          ; (require 'helm-gtags)

                          ;; configuration helm variable
                          (setq helm-idle-delay 0.2)
                          (setq helm-input-idle-delay 0)
                          (setq helm-candidate-number-limit 100)

                          (require 'helm-files)

                          (defun helm-my ()
                            (interactive)
                            (helm-other-buffer '(helm-c-source-buffers-list
                                                 helm-c-source-elscreen
                                                 helm-c-source-recentf
                                                 helm-c-source-ctags
                                                 helm-c-source-buffer-not-found)
                                               "*helm my*"))

                          (defun helm-with-new-elscreen ()
                            "新しい elscreen で helm"
                            (interactive)
                            (elscreen-create)
                            (helm-my))

                          (define-key global-map (kbd "C-;") 'helm-my)
                          (define-key global-map (kbd "C-:") 'helm-with-new-elscreen)
                          (global-set-key (kbd "C-x C-f") 'helm-find-files)
                          (global-set-key (kbd "M-y") 'helm-show-kill-ring)

                          (global-set-key (kbd "C-q i") 'helm-imenu)


                          ))

          (:name helm-descbinds-github
                 :type github
                 :url "git://github.com/emacs-helm/helm-descbinds.git"
                 :after (progn

                          (require 'helm-descbinds)
                          (helm-descbinds-install)

                          (key-chord-define-global "df" 'helm-descbinds)

                          ))

          ; (:name anything-howm
                 ; :type github
                 ; :url "git://github.com/mori-dev/anything-howm.git"
                 ; :after (progn
                          ; (require 'anything-howm)

                          ; (defun anything-howm-with-new-elscreen ()
                            ; "新しい elscreen で anything-howm"
                            ; (interactive)
                            ; (elscreen-create)
                            ; (ah:menu-command)
                            ; (howm-mode))

                          ; (global-set-key (kbd "C-c C-, C-,") 'anything-howm-with-new-elscreen)

                          ; ;; 「最近のメモ」をいくつ表示するか
                          ; (setq ah:recent-menu-number-limit 600)

                          ; (global-set-key (kbd "C-2") 'ah:menu-command)
                          ; (global-set-key (kbd "C-3") 'ah:cached-howm-menu)

                          ; ;; howm のデータディレクトリへのパス
                          ; (setq ah:data-directory "~/howm")

                          ; ))

          ;;          (:name yasnippet
          ;;       :type git
          ;;       :url "https://github.com/capitaomorte/yasnippet.git"
          ;;                 :after (lambda ()
          ;;                          (require 'yasnippet)
          ;;                          (yas/global-mode 1)
          ;;                          (yas/load-directory "~/.emacs.d/dict")
          ;;
          ;;                          (defun my-yas/prompt (prompt choices &optional display-fn)
          ;;                            (let* ((names (loop for choice in choices
          ;;                                                collect (or (and display-fn (funcall display-fn choice))
          ;;                                                            coice)))
          ;;                                   (selected (anything-other-buffer
          ;;                                              `(((name . ,(format "%s" prompt))
          ;;                                                 (candidates . names)
          ;;                                                 (action . (("Insert snippet" . (lambda (arg) arg))))))
          ;;                                              "*anything yas/prompt*")))
          ;;                              (if selected
          ;;                                  (let ((n (position selected names :test 'equal)))
          ;;                                    (nth n choices))
          ;;                                (signal 'quit "user quit!"))))
          ;;                          (custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))
          ;;                          (global-set-key (kbd "C-c y") 'yas/insert-snippet)
          ;;
          ;;                          ))
          (:name popwin
                 :type github
                 :url "git://github.com/m2ym/popwin-el.git"
                 :after (progn
                          (require 'popwin)
                          (setq display-buffer-function 'popwin:display-buffer)
                          ;; anythingをpopwinで行うため
                          (setq anything-samewindow nil)
                          ;; popwinのデフォルトサイズ
                          (setq popwin:popup-window-height 0.4)
                          ;; popwinを使う表示を設定
                          (setq popwin:special-display-config
                                (append '(("*Remember*" :stick t)
                                          ("*Backtrace*")
                                          ("*Messages*")
                                          ("*Completion*" :height 0.2)
                                          ("*Compile-Log*")
                                          ("*compilation*") ; for rst-compile
                                          ("*sdic*" :noselect t)
                                          ("*anything*" :height 20)
                                          ("*my-anything-all*" :height 20)
                                          ("*my-anything-buf-screens*" :height 20)
                                          ("*anything-my-imenu*" :height 20)
                                          ;;("*Moccur*" :height 20)
                                          ("*Directory*" :height 20)
                                          ("*undo-tree*" :height 20)
                                          ("\\*magit*" :regexp t :height 30)
                                          (dired-mode :position top :height 0.6)
                                          ;; slime
                                          ("*slime-apropos*")
                                          ("*slime-macroexpansion*")
                                          ("*slime-description*")
                                          ("*slime-compilation*" :noselect t)
                                          ("*slime-xref*")
                                          ("*slime-repl clojure*" :height 30)
                                          ("*slime-repl ccl*" :height 30)
                                          ("\\*sldb clojure*" :regexp t :height 30)
                                          (sldb-mode :stick t)
                                          (slime-repl-mode)
                                          (slime-connection-list-mode)
                                          (direx:direx-mode :position left :width 25 :dedicated t)
                                          ("*auto-async-byte-compile*" :height 20)
                                          ("*Shell Command Output*" :height 25)
                                          ("*svn output*" :stick t :position right)
                                          )
                                        popwin:special-display-config))

                          ;; 最後に表示したpopwinを再表示
                          (define-key global-map (kbd "C-x p") 'popwin:display-last-buffer)))
          (:name magit
                 ;; make するとエラーが出るので独自で git pull
                 :type github
                 :url "http://github.com/magit/magit.git"
                 :after (progn
                          (require 'magit)
                          (global-set-key (kbd "C-q g") 'magit-status)
                          ;; 色変更
                          (set-face-foreground 'magit-diff-add "#b9ca4a")
                          (set-face-foreground 'magit-diff-del "#d54e53")
                          (set-face-background 'magit-item-highlight "gray25")
                          ))

          (:name auto-complete
                 :type github
                 :url "git://github.com/auto-complete/auto-complete.git"
                 :after (progn
                          (require 'auto-complete)
                          (require 'auto-complete-config)
                          (global-auto-complete-mode t)
                          (setq ac-dwim t)
                          ;; ;; 辞書ファイルの位置
                          (add-to-list 'ac-dictionary-directories "~/.emacs.d/el-get/auto-complete/dict")

                          ;; デフォルト設定有効
                          (ac-config-default)
                          ;; 補完を高度に
                          (define-key ac-mode-map (kbd "TAB") 'auto-complete)

                          ;; 自動補完
                          (setq ac-auto-start 3) ; ?文字以上で補完開始
                          ;; 手動補完するならこっち
                          ;; (setq ac-auto-start nil) ; 自動的に開始しない

                          ;; 一定時間後に保管開始
                          (setq ac-auto-show-menu 1.0)

                          ;; コンテキストに応じてTABで補完
                          (ac-set-trigger-key "TAB")
                          ;; 補完確定
                          (define-key ac-complete-mode-map "RET" 'ac-complete)

                          (setq ac-use-menu-map t)
                          ;; デフォルトで設定済み
                          ;; (define-key ac-menu-map "\C-n" 'ac-next)
                          ;; (define-key ac-menu-map "\C-p" 'ac-previous)

                          ;; tab補完で候補が選択されないようにする
                          (define-key ac-menu-map [(tab)] 'ac-next)
                          (define-key ac-menu-map [(S-tab)] 'ac-previous)


                          ;; 補完時大文字小文字の区別
                          ;; 大文字・小文字を区別しない
                          (setq ac-ignore-case t) ;区別無し

                          ;; 補完の色
                          (set-face-background 'ac-candidate-face "#b9ca4a")
                          (set-face-underline 'ac-candidate-face "#b9ca4a")
                          (set-face-background 'ac-selection-face "#d54e53")

                          ;; 候補を20行分表示
                          (setq ac-menu-height 20)

                          ;; 補完の情報源
                          (require 'auto-complete-etags)
                          (setq-default ac-sources
                                        ;; '(ac-source-abbrev ac-source-yasnippet ac-source-filename ac-source-files-in-current-dir ac-source-words-in-same-mode-buffers ac-source-symbols))
                                        '(ac-source-abbrev ac-source-etags ac-source-yasnippet ac-source-files-in-current-dir ac-source-words-in-same-mode-buffers ac-source-symbols))
                          ;; 補完するモードの追加
                          (setq ac-modes (append ac-modes '(text-mode sql-mode scala-mode java-mode haskell-mode)))
                          ))

          (:name expand-region
                 :type github
                 :url "git://github.com/magnars/expand-region.el.git"
                 :after (progn
                          (require 'expand-region)
                          (global-set-key (kbd "C-@") 'er/expand-region)
                          (global-set-key (kbd "C-M-@") 'er/contract-region) ;; リージョンを狭める
                          ))

          (:name wrap-region
                 :type github
                 :url "git://github.com/rejeep/wrap-region.git"
                 :after (progn
                          (require 'wrap-region)
                          ;; 第一引数:リージョンの先頭に挿入する文字
                          ;; 第二引数:リージョン末尾に挿入する文字
                          ;; 第三引数:トリガとなるキー
                          ;; 第四引数:有効にするモード
                          ;; (wrap-region-add-wrapper "(" ")" "(")
                          ))

          ;; (:name jaunte.el
          ;;        :type git
          ;;        :url "git://github.com/kawaguchi/jaunte.el.git"
          ;;        :after (progn
          ;;                 (require 'jaunte)
          ;;                 ;; グローバルに設定
          ;;                 (setq jaunte-global-hint-unit 'symbol)
          ;;                 (global-set-key (kbd "C-c C-j") 'jaunte)
          ;;                 (key-chord-define-global "qf" 'jaunte)
          ;;                 ))

          ;; (:name rainbow-delimiters
          ;;        :type git
          ;;        :url "git://github.com/jlr/rainbow-delimiters.git"
          ;;        :after (progn
          ;;                 (require 'rainbow-delimiters)
          ;;                 (global-rainbow-delimiters-mode)
          ;;                 ))

          (:name twittering-mode
                 :type github
                 :url "git://github.com/hayamiz/twittering-mode.git")

          (:name coffee-mode
                 :after (progn
                          (progn 
                            (require 'coffee-mode)
                            (add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
                            (add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode)))
                          ))

          (:name scratch-log
                 :type github
                 :url "git://github.com/mori-dev/scratch-log.git"
                 :after (progn
                          (require 'scratch-log)
                          (setq sl-scratch-log-file "~/.emacs.d/.scratch-log")
                          (setq sl-prev-scratch-string-file "~/.emacs.d/.scratch-log-prev")

                          ;; nil なら emacs 起動時に，最後に終了したときの スクラッチバッファの内容を復元しない。初期値は t です。
                          (setq sl-restore-scratch-p nil)
                          ;; nil なら スクラッチバッファを削除できるままにする。初期値は t です。
                          (setq sl-prohibit-kill-scratch-buffer-p t)
                          ))

          ;; (:name shadow.el
          ;;        :type git
          ;;        :url "git://github.com/mooz/shadow.el.git"
          ;;        :after (progn
          ;;                 (require 'shadow)
          ;;                 (add-hook 'find-file-hooks 'shadow-on-find-file)
          ;;                 (add-hook 'shadow-find-unshadow-hook
          ;;                           (lambda () (auto-revert-mode 1)))
          ;;                 ))

          ;; (:name emacs-window-layout
          ;;        :type git
          ;;        :url "git://github.com/kiwanami/emacs-window-layout.git"
          ;;        )
          ;; (:name emacs-window-manager
          ;;        :type git
          ;;        :url "git://github.com/kiwanami/emacs-window-manager.git"
          ;;        :after (progn
          ;;                 (require 'e2wm)
          ;;                 (global-set-key (kbd "M-+") 'e2wm:start-management)
          ;;                 (require 'e2wm-vcs)
          ;;                 (global-set-key (kbd "C-q g") 'e2wm:dp-magit)
          ;;                 ))

          ;; (:name direx-el
          ;;        :type git
          ;;        :url "git://github.com/m2ym/direx-el.git"
          ;;        :after (progn
          ;;                 (require 'direx)
          ;;                 (global-set-key (kbd "C-x j") 'direx:jump-to-directory-other-window)
          ;;                 ;; (setq direx:leaf-icon "  "
          ;;                 ;;       direx:open-icon "+ "
          ;;                 ;;       direx:closed-icon "> ")
          ;;                 ))

          ;; (:name anything-replace-string
          ;;        :type git 
          ;;        :url "git://github.com/k1LoW/anything-replace-string.git"
          ;;        :after (progn
          ;;                 (require 'anything-replace-string)
          ;;                 (global-set-key (kbd "C-c r") 'anything-replace-string)
          ;;                 ))

          (:name BESI ;Better Emacs-Scala Indentation
                 :type git
                 :url "git://github.com/Rogach/besi.git"
                 :after (progn
                          (require 'besi)
                          ))

          (:name haskell-mode
                 :type git
                 :url "git://github.com/haskell/haskell-mode.git"
                 :after (progn
                          (load "~/.emacs.d/el-get/haskell-mode/haskell-site-file")
                          (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
                          ;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
                          ;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
                          ;; (add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

                          (add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
                          (add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
                          (add-to-list 'auto-mode-alist '("\\.cabal\\'" . haskell-cabal-mode))

                          ;; ghc-mod
                          ;; cabal でインストールしたライブラリのコマンドが格納されている bin ディレクトリへのパスを exec-path に追加する
                          (add-to-list 'exec-path (concat (getenv "HOME") "/.cabal/bin"))
                          ;; ghc-flymake.el などがあるディレクトリ ghc-mod
                          (add-to-list 'load-path "~/.emacs.d/elisp/ghc-mod-1.10.15")
                          (autoload 'ghc-init "ghc" nil t)
                          (add-hook 'haskell-mode-hook
                                    (lambda () (ghc-init)))

                          ;; auto-complete
                          (ac-define-source ghc-mod
                            '((depends ghc)
                              (candidates . (ghc-select-completion-symbol))
                              (symbol . "s")
                              (cache)))

                          ;; indent
                          (custom-set-variables
                           '(haskell-mode-hook '(turn-on-haskell-indentation)))

                          (defun my-ac-haskell-mode ()
                            (setq ac-sources '(ac-source-words-in-same-mode-buffers ac-source-dictionary ac-source-ghc-mod)))
                          (add-hook 'haskell-mode-hook 'my-ac-haskell-mode)

                          (defun my-haskell-ac-init ()
                            (when (member (file-name-extension buffer-file-name) '("hs" "lhs"))
                              (auto-complete-mode t)
                              (setq ac-sources '(ac-source-words-in-same-mode-buffers ac-source-dictionary ac-source-ghc-mod))))

                          (add-hook 'find-file-hook 'my-haskell-ac-init)


                          ))

          (:name android-mode
                 :type github
                 :url "git://github.com/remvee/android-mode.git"
                 :after (progn
                          (require 'android-mode)
                          (setq android-mode-sdk-dir "~/android/android-sdk")
                          ))




          ))

  (setq my-packages
        (append '(el-get) (mapcar 'el-get-source-name el-get-sources)))
  ;; (append '(el-get) (mapcar 'el-get-as-symbol (mapcar 'el-get-source-name el-get-sources))))
  (el-get 'sync my-packages)
  ;; (el-get 'wait)

  )

