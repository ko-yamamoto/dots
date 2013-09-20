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

          (:name exec-path-from-shell-github
                 :type github
                 :url "https://github.com/purcell/exec-path-from-shell.git"
                 :after (progn
                          (require 'exec-path-from-shell)
                          (exec-path-from-shell-initialize)
                          (let ((envs '("PATH" "VIRTUAL_ENV" "GOROOT" "GOPATH")))
                            (exec-path-from-shell-copy-envs envs))
                          (setq eshell-path-env (getenv "PATH"))
                          ))

          ;;           (:name org-mode-git
          ;;                  :type git
          ;;                  :url "git://orgmode.org/org-mode.git")

          (:name helm-github
                 :type github
                 :url "git://github.com/emacs-helm/helm.git"
                 :after (progn
                          (require 'helm-config)
                          (helm-mode 1)
                                        ; (require 'helm-gtags)
                          ;; configuration helm variable
                          (setq helm-idle-delay 0.1)
                          (setq helm-input-idle-delay 0.1) ; 入力後に候補を更新するまでの時間
                          (setq helm-candidate-number-limit 300) ; 候補数
                          (setq helm-buffer-max-length 80) ; バッファ名の最大長
                          (setq enable-recursive-minibuffers t)

                          (require 'helm-files)

                          ;; action を buffer kill に入れ替えたものソース
                          (defun helm-c-buffers-list-R-persistent-action (candidate)
                            (if current-prefix-arg
                                (helm-c-switch-to-buffer candidate)
                              (helm-c-buffers-persistent-kill candidate)))

                          (defvar helm-c-source-buffers-list-R
                            `((name . "Buffers")
                              (init . (lambda ()
                                        ;; Issue #51 Create the list before `helm-buffer' creation.
                                        (setq helm-buffers-list-cache (helm-buffer-list))
                                        (unless helm-buffer-max-length
                                          (let ((result (loop for b in helm-buffers-list-cache
                                                              maximize (length b) into len-buf
                                                              maximize (length (with-current-buffer b
                                                                                 (symbol-name major-mode)))
                                                              into len-mode
                                                              finally return (cons len-buf len-mode))))
                                            (setq helm-buffer-max-length (car result)
                                                  helm-buffer-max-len-mode (cdr result))))))
                              (candidates . helm-buffers-list-cache)
                              (type . buffer)
                              (match helm-buffer-match-major-mode)
                              (persistent-action . helm-c-buffers-list-R-persistent-action)
                              (keymap . ,helm-buffer-map)
                              (volatile)
                              (no-delay-on-input)
                              (mode-line . helm-buffer-mode-line-string)
                              (persistent-help
                               . "Kill this buffer / C-u \\[helm-execute-persistent-action]: Show this buffer")))

                          ;; ディレクトリだけのソース
                          (defvar helm-c-recentf-directory-source
                            '((name . "Recentf Directry")
                              (candidates . (lambda ()
                                              (loop for file in recentf-list
                                                    when (file-directory-p file)
                                                    collect file)))
                              (type . file)))
                          ;; ファイルだけのソース
                          (defvar helm-c-recentf-file-source
                            '((name . "Recentf File")
                              (candidates . (lambda ()
                                              (loop for file in recentf-list
                                                    when (not (file-directory-p file))
                                                    collect file)))
                              (type . file)))

                          (defun helm-my ()
                            (interactive)
                            (helm-other-buffer '(helm-c-source-elscreen
                                                 helm-c-source-buffers-list-R
                                                 helm-c-recentf-file-source
                                                 helm-c-recentf-directory-source
                                                 helm-c-source-buffer-not-found)
                                               "*helm my*"))

                          (define-key global-map (kbd "C-;") 'helm-my)
                          ;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
                          (global-set-key (kbd "M-y") 'helm-show-kill-ring)

                          (global-set-key (kbd "M-i") 'helm-imenu)


                          ;; git 管理ファイルを状態に応じて表示
                          (defun helm-c-sources-git-project-for (pwd)
                            (loop for elt in
                                  '(("Modified files" . "--modified")
                                    ("Untracked files" . "--others --exclude-standard")
                                    ("All controlled files in this project" . nil))
                                  for title  = (format "%s (%s)" (car elt) pwd)
                                  for option = (cdr elt)
                                  for cmd    = (format "git ls-files %s" (or option ""))
                                  collect
                                  `((name . ,title)
                                    (init . (lambda ()
                                              (unless (and (not ,option) (helm-candidate-buffer))
                                                (with-current-buffer (helm-candidate-buffer 'global)
                                                  (call-process-shell-command ,cmd nil t nil)))))
                                    (candidates-in-buffer)
                                    (type . file))))
                          (defun helm-git-project-topdir ()
                            (file-name-as-directory
                             (replace-regexp-in-string
                              "\n" ""
                              (shell-command-to-string "git rev-parse --show-toplevel"))))
                          (defun helm-git-project ()
                            (interactive)
                            (let ((topdir (helm-git-project-topdir)))
                              (unless (file-directory-p topdir)
                                (error "I'm not in Git Repository!!"))
                              (let* ((default-directory topdir)
                                     (sources (helm-c-sources-git-project-for default-directory)))
                                (helm-other-buffer sources "*helm git project*"))))

                          (global-set-key (kbd "C-q ;") 'helm-git-project)


                          ))

          (:name helm-descbinds-github
                 :type github
                 :url "git://github.com/emacs-helm/helm-descbinds.git"
                 :after (progn

                          (require 'helm-descbinds)
                          (helm-descbinds-install)

                          (key-chord-define-global "df" 'helm-descbinds)

                          ))

          (:name helm-c-yasnippet-github
                 :type github
                 :url "git://github.com/emacs-helm/helm-c-yasnippet.git"
                 ) ;; use this elisp in yasnippet's :after

          (:name yasnippet
                 :website "https://github.com/capitaomorte/yasnippet.git"
                 :description "YASnippet is a template system for Emacs."
                 :type github
                 :pkgname "capitaomorte/yasnippet"
                 :features "yasnippet"
                 :compile "yasnippet.el"
                 :submodule nil
                 :after (progn
                          (require 'yasnippet)
                          (setq yas-snippet-dirs
                                '("~/.emacs.d/mysnippets"
                                  "~/.emacs.d/el-get/yasnippet/snippets"
                                  ))
                          (yas-global-mode 1)

                          (custom-set-variables '(yas-trigger-key "SPC"))

                          ;; 既存スニペットを挿入する
                          (define-key yas-minor-mode-map (kbd "C-c y i") 'yas-insert-snippet)
                          ;; 新規スニペットを作成するバッファを用意する
                          (define-key yas-minor-mode-map (kbd "C-c y n") 'yas-new-snippet)
                          ;; 既存スニペットを閲覧・編集する
                          (define-key yas-minor-mode-map (kbd "C-c y v") 'yas-visit-snippet-file)

                          (require 'helm-c-yasnippet)
                          (setq helm-c-yas-space-match-any-greedy t) ;[default: nil]
                          (global-set-key (kbd "C-c y y") 'helm-c-yas-complete)
                          ))


          (:name popwin
                 :type github
                 :url "git://github.com/m2ym/popwin-el.git"
                 :after (progn
                          (require 'popwin)
                          (setq display-buffer-function 'popwin:display-buffer)

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
                                          ("*helm \\(.*\\)*" :regexp t :height 0.35)
                                          ;; ("\\(.*\\) \\[Dired\\]" :regexp t :height 0.4 :position top :stick t)
                                          ;;("*Moccur*" :height 20)
                                          ("*Directory*" :height 20)
                                          ("\\*magit*" :regexp t :height 30)
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
                                          ("\\*nrepl-*" :height 0.3 :regexp t)
                                          )
                                        popwin:special-display-config))

                          ;; 最後に表示したpopwinを再表示
                          (define-key global-map (kbd "C-c p") 'popwin:display-last-buffer)))

          (:name cl-lib
                 ;; :builtin "24.3"
                 :type elpa
                 :description "Properly prefixed CL functions and macros"
                 :url "http://elpa.gnu.org/packages/cl-lib.html")
          (:name git-modes
                 :description "GNU Emacs modes for various Git-related files"
                 :type github
                 :pkgname "magit/git-modes")
          (:name magit
                 ;; make するとエラーが出るので独自で git pull
                 :type github
                 :url "http://github.com/magit/magit.git"
                 :depends (cl-lib git-modes)
                 :after (progn
                          (require 'magit)

                          ;; magit をバッファ全体に開く
                          (setq magit-status-buffer-switch-function 'switch-to-buffer)

                          (require 'vc)
                          (defun magit-status-with-new-elscreen ()
                            "新しい elscreen で magit status"
                            (interactive)
                            (setq my/now-point (buffer-file-name))
                            (elscreen-create)
                            (magit-status (vc-call-backend (vc-responsible-backend my/now-point) 'root my/now-point)))

                          (global-set-key (kbd "C-c g g") 'magit-status-with-new-elscreen)
                          (global-set-key (kbd "C-c g d") 'magit-diff-working-tree)
                          (global-set-key (kbd "C-c g f") 'magit-file-log)

                          ;; 色変更
                          ;; (set-face-foreground 'magit-diff-add "#b9ca4a")
                          ;; (set-face-background 'magit-diff-add "#000000")
                          ;; (set-face-foreground 'magit-diff-del "#d54e53")
                          ;; (set-face-background 'magit-diff-del "#000000")
                          ;; (set-face-background 'magit-item-highlight "#000000")
                          ))

          (:name popup-el-github
                 :type github
                 :url "git://github.com/auto-complete/popup-el.git"
                 )

          (:name auto-complete-github
                 :type github
                 :url "git://github.com/auto-complete/auto-complete.git"
                 :after (progn

                          (require 'auto-complete-config)
                          (ac-config-default)
                          (global-auto-complete-mode t)

                          ;; 補完メニュー表示時に特別なキーマップを有効にするか
                          (setq ac-use-menu-map t)
                          ;; 辞書ファイルの位置
                          (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
                          ;; 補完の開始キー
                          (define-key ac-mode-map (kbd "M-c") 'auto-complete)
                          ;; 補完を止めるキー
                          (define-key ac-menu-map "q" 'ac-stop)
                          ;; 補完メニュー表示までのディレイ
                          (setq ac-auto-show-menu 0.3)
                          ;;補完メニューの行数
                          (setq ac-menu-height 15)
                          ;; 大文字・小文字の区別方法
                          (setq ac-ignore-case 'smart)
                          ;; 補完選択時にTABをRETの挙動にしない
                          (setq ac-dwim nil)
                          ;; 表示崩れ防止
                          (setq popup-use-optimized-column-computation nil)

                          ;; 追加モード
                          (add-to-list 'ac-modes 'org-mode)

                          ))

          (:name ac-slime-github
                 :type github
                 :url "git://github.com/purcell/ac-slime.git"
                 :after (progn
                          (require 'ac-slime)
                          (add-hook 'slime-mode-hook 'set-up-slime-ac)
                          (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
                          (eval-after-load "auto-complete"
                            '(add-to-list 'ac-modes 'slime-repl-mode))
                          ))

          (:name expand-region
                 :type github
                 :url "git://github.com/magnars/expand-region.el.git"
                 :after (progn
                          (require 'expand-region)
                          (global-set-key (kbd "C-@") 'er/expand-region)
                          (global-set-key (kbd "C-M-@") 'er/contract-region) ;; リージョンを狭める
                          (global-set-key (kbd "C-=") 'er/expand-region)
                          (global-set-key (kbd "C-M-=") 'er/contract-region) ;; リージョンを狭める
                          (global-set-key (kbd "C-o") 'er/expand-region)
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

          (:name rainbow-delimiters
                 :type git
                 :url "git://github.com/jlr/rainbow-delimiters.git"
                 :after (progn
                          (require 'rainbow-delimiters)
                          (global-rainbow-delimiters-mode)
                          ))

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
                          (setq sl-restore-scratch-p t)
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


          (:name haskell-mode
                 :type git
                 :url "git://github.com/haskell/haskell-mode.git"
                 :after (progn
                          ;; (load "~/.emacs.d/el-get/haskell-mode/haskell-site-file")
                          (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
                          ;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
                          ;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
                          ;; (add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

                          ;; (add-to-list 'auto-mode-alist '("\\.hs" . haskell-mode))
                          ;; (add-to-list 'auto-mode-alist '("\\.lhs" . literate-haskell-mode))
                          ;; (add-to-list 'auto-mode-alist '("\\.cabal" . haskell-cabal-mode))

                          ;; ghc-mod
                          ;; cabal でインストールしたライブラリのコマンドが格納されている bin ディレクトリへのパスを exec-path に追加する
                          (add-to-list 'exec-path (concat (getenv "HOME") "/.cabal/bin"))
                          ;; ghc-flymake.el などがあるディレクトリ ghc-mod
                          ;; (add-to-list 'load-path "~/.emacs.d/elisp/ghc-mod-1.10.15")
                          ;; (autoload 'ghc-init "ghc" nil t)
                          ;; (add-hook 'haskell-mode-hook
                          ;;           (lambda () (ghc-init)))

                          ;; auto-complete
                          (ac-define-source ghc-mod
                            '((depends ghc)
                              (candidates . (ghc-select-completion-symbol))
                              (symbol . "s")
                              (cache)))

                          ;; indent
                          (remove-hook 'haskell-mode-hook 'turn-on-haskell-indent)
                          (remove-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
                          (defun my-haskell-mode-hook ()
                            (haskell-indentation-mode -1) ;; turn off, just to be sure
                            (haskell-indent-mode 1))      ;; turn on indent-mode
                          (add-hook 'haskell-mode-hook 'my-haskell-mode-hook)


                          (defun my-ac-haskell-mode ()
                            (setq ac-sources '(ac-source-words-in-same-mode-buffers ac-source-dictionary ac-source-ghc-mod)))
                          (add-hook 'haskell-mode-hook 'my-ac-haskell-mode)

                          (defun my-haskell-ac-init ()
                            (when (member (file-name-extension buffer-file-name) '("hs" "lhs"))
                              (auto-complete-mode t)
                              (setq ac-sources '(ac-source-words-in-same-mode-buffers ac-source-dictionary ac-source-ghc-mod))))

                          (add-hook 'haskell-mode-hook 'my-haskell-ac-init)


                          ))

          (:name android-mode
                 :type github
                 :url "git://github.com/remvee/android-mode.git"
                 :after (progn
                          (require 'android-mode)
                          (setq android-mode-sdk-dir "~/android/android-sdk")
                          ))

          (:name emacs-yalinum-github
                 :type github
                 :url "git://github.com/myuhe/emacs-yalinum.git"
                 :after (progn
                          (require 'yalinum)
                          ;; (global-yalinum-mode t)
                          (global-set-key (kbd "M-n") 'yalinum-mode)
                          ))

          (:name back-button.el-github
                 :type github
                 :url "git://github.com/rolandwalker/back-button.git"
                 :after (progn
                          (require 'back-button)
                          (back-button-mode 1)
                          ))

          ;; (:name mark-multiple.el-github
          ;;        :type github
          ;;        :url "git://github.com/magnars/mark-multiple.el.git"
          ;;        :after (progn
          ;;                 (require 'mark-more-like-this)
          ;;                 (global-set-key (kbd "C-<") 'mark-previous-like-this)
          ;;                 (global-set-key (kbd "C->") 'mark-next-like-this)
          ;;                 ))

          ;; (:name emacs-powerline-github
          ;;        :type github
          ;;        :url "git://github.com/jonathanchu/emacs-powerline.git"
          ;;        :after (progn
          ;;                 (require 'powerline)
          ;;                 (require 'cl)

          ;;                 ;; 境界の形を1つ選択
          ;;                 ;; (setq powerline-arrow-shape 'arrow)   ;; the default
          ;;                 ;; (setq powerline-arrow-shape 'curve)   ;; give your mode-line curves
          ;;                 (setq powerline-arrow-shape 'arrow14) ;; best for small fonts

          ;;                 ;; (custom-set-faces
          ;;                 ;;  '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
          ;;                 ;;  '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))

          ;;                 ;; 色
          ;;                 (setq powerline-color1 "grey22")
          ;;                 (setq powerline-color2 "grey40")

          ;;                 ))

          (:name elscreen-24-ns-github
                 :type github
                 :url "git://github.com/nishikawasasaki/elscreen.git"
                 :after (progn
                          (require 'elscreen)
                          (elscreen-start)
                          ;; タブコントロールを左端に表示しない
                          (setq elscreen-tab-display-control nil)
                          ;; タブを閉じる [X] を表示しない
                          (setq elscreen-tab-display-kill-screen nil)
                          ;; タブの幅
                          (setq elscreen-display-tab 15)

                          ;; タブが1つの時にタブ移動をすると自動でスクリーンを生成する
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

                          ;; 切り替えキー
                          (global-set-key (kbd "<C-tab>") 'elscreen-next)
                          (global-set-key (kbd "<C-S-tab>") 'elscreen-previous)
                          (global-set-key (kbd "<C-S-iso-lefttab>") 'elscreen-previous)

                          ;; emacsclient からは別のタブで開く
                          (require 'elscreen-server nil t)

                          (defun helm-with-new-elscreen ()
                            "新しい elscreen で helm"
                            (interactive)
                            (elscreen-create)
                            (helm-my))
                          (define-key global-map (kbd "C-:") 'helm-with-new-elscreen)

                          (defun dired-with-new-elscreen ()
                            "新しい elscreen で dired"
                            (interactive)
                            (let ((current-dir (expand-file-name ".")))
                              (elscreen-create)
                              (dired current-dir)))
                          (define-key global-map (kbd "C-x j") 'dired-with-new-elscreen)

                          (define-key global-map (kbd "C-z C-c") 'elscreen-clone)
                          (define-key global-map (kbd "C-z C-k") 'elscreen-kill-screen-and-buffers)


                          ))



          ;; (:name tabbar-github
          ;;        :type github
          ;;        :url "git://github.com/CMPITG/tabbar.el.git"
          ;;        :after (progn

          ;;                 (require 'tabbar)
          ;;                 (tabbar-mode 1)

          ;;                 ;; グループを使わない
          ;;                 (setq tabbar-buffer-groups-function nil)

          ;;                 ;; 左側のボタンを消す
          ;;                 (dolist (btn '(tabbar-buffer-home-button
          ;;                                tabbar-scroll-left-button
          ;;                                tabbar-scroll-right-button))
          ;;                   (set btn (cons (cons "" nil)
          ;;                                  (cons "" nil))))


          ;;                 ;; ウィンドウからタブがはみ出たときの動作
          ;;                 ;; タブをスクロールさせる（デフォルト）
          ;;                 (setq tabbar-auto-scroll-flag t)
          ;;                 ;; タブを省略して表示
          ;;                 ;; (setq tabbar-auto-scroll-flag nil)

          ;;                 ;; 切り替えキー
          ;;                 (global-set-key (kbd "<C-tab>") 'tabbar-forward-tab)
          ;;                 (global-set-key (kbd "<C-S-tab>") 'tabbar-backward-tab)
          ;;                 (global-set-key (kbd "<C-S-iso-lefttab>") 'tabbar-backward-tab)

          ;;                 ;; タブ名の間隔
          ;;                 (setq tabbar-separator '(1.5))

          ;;                 ;; タブに表示させるバッファの設定
          ;;                 (defvar my-tabbar-displayed-buffers
          ;;                   '("*Backtrace*" "*Colors*" "*Faces*" "*vc-" "*eshell*")
          ;;                   "*Regexps matches buffer names always included tabs.")
          ;;                 (defun my-tabbar-buffer-list ()
          ;;                   (let* ((hides (list ?\  ?\*))
          ;;                          (re (regexp-opt my-tabbar-displayed-buffers))
          ;;                          (cur-buf (current-buffer))
          ;;                          (tabs (delq nil
          ;;                                      (mapcar (lambda (buf)
          ;;                                                (let ((name (buffer-name buf)))
          ;;                                                  (when (or (string-match re name)
          ;;                                                            (not (memq (aref name 0) hides)))
          ;;                                                    buf)))
          ;;                                              (buffer-list)))))
          ;;                     ;; Always include the current buffer.
          ;;                     (if (memq cur-buf tabs)
          ;;                         tabs
          ;;                       (cons cur-buf tabs))))
          ;;                 (setq tabbar-buffer-list-function 'my-tabbar-buffer-list)

          ;;                 ;; 外観変更
          ;;                 (set-face-attribute
          ;;                  'tabbar-default nil
          ;;                  :family "ricty"
          ;;                  :background "black"
          ;;                  :foreground "gray72"
          ;;                  :height 0.8)
          ;;                 (set-face-attribute
          ;;                  'tabbar-unselected nil
          ;;                  :background "black"
          ;;                  :foreground "grey72"
          ;;                  :box nil)
          ;;                 (set-face-attribute
          ;;                  'tabbar-selected nil
          ;;                  :background "black"
          ;;                  :foreground "#eab700"
          ;;                  :box nil)
          ;;                 (set-face-attribute
          ;;                  'tabbar-button nil
          ;;                  :box nil)
          ;;                 (set-face-attribute
          ;;                  'tabbar-separator nil
          ;;                  :height 1.0)

          ;;                 ))

          (:name git-gutter.el-github
                 :type github
                 :url "git://github.com/syohex/emacs-git-gutter.git"
                 :after (progn
                          (require 'git-gutter)

                          ;; (global-git-gutter-mode t) ;; el-get が誤作動するため global は使わない
                          ;; 指定したモードで有効に
                          (let ((mode-hooks
                                 '(emacs-lisp-mode-hook
                                   org-mode-hook
                                   java-mode-hook
                                   lisp-mode-hook
                                   clojure-mode-hook
                                   scala-mode-hook
                                   haskell-mode-hook
                                   sh-mode-hook)))
                            (mapcar (lambda (mode-hook) (add-hook mode-hook 'git-gutter-mode)) mode-hooks))

                          ;; 表示変更
                          (setq git-gutter:window-width 1)
                          ;; (setq git-gutter:added-sign "☀")
                          ;; (setq git-gutter:modified-sign "☁")
                          ;; (setq git-gutter:deleted-sign "☂")
                          (setq git-gutter:added-sign "|")
                          (setq git-gutter:modified-sign "|")
                          (setq git-gutter:deleted-sign "|")
                          ;; 色変更
                          (set-face-foreground 'git-gutter:added "#afd900")
                          (set-face-foreground 'git-gutter:modified "#eab700")
                          (set-face-foreground 'git-gutter:deleted "#c82829")

                          ;; ignore all spaces
                          (setq git-gutter:diff-option "-w")

                          (global-set-key (kbd "C-c g c") 'git-gutter:toggle)

                          ))
          (:name git-gutter-fringe-github
                 :type github
                 :url "git://github.com/syohex/emacs-git-gutter-fringe.git"
                 :after (progn
                          ;; You need to install fringe-helper.el
                          (require 'git-gutter-fringe)
                          ;; 色変更
                          (set-face-foreground 'git-gutter-fr:added "#afd900")
                          (set-face-foreground 'git-gutter-fr:modified "#eab700")
                          (set-face-foreground 'git-gutter-fr:deleted "#c82829")
                          ;; 形変更
                          (fringe-helper-define 'git-gutter-fr:added nil
                            "...XXXX.."
                            "...XXXX.."
                            "...XXXX.."
                            "...XXXX.."
                            "...XXXX.."
                            "...XXXX.."
                            "...XXXX.."
                            "...XXXX..")
                          (fringe-helper-define 'git-gutter-fr:deleted nil
                            "...XXXX.."
                            "...XXXX.."
                            "...XXXX.."
                            "...XXXX.."
                            "...XXXX.."
                            "...XXXX.."
                            "...XXXX.."
                            "...XXXX..")
                          (fringe-helper-define 'git-gutter-fr:modified nil
                            "...XXXX.."
                            "...XXXX.."
                            "...XXXX.."
                            "...XXXX.."
                            "...XXXX.."
                            "...XXXX.."
                            "...XXXX.."
                            "...XXXX..")

                          ))


          (:name multiple-cursors-github
                 :type github
                 :url "git://github.com/magnars/multiple-cursors.el.git"
                 :after (progn

                          (require 'multiple-cursors)

                          ;; ;; 複数行選択してから全ての行にカーソル追加
                          ;; (global-set-key (kbd "C-c m m") 'mc/edit-lines)
                          ;; ;; リージョンと一致する箇所で現在行より下にあるもの1つを追加
                          ;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
                          ;; ;; リージョンと一致する箇所で現在行より上にあるもの1つを追加
                          ;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
                          ;; ;; リージョンと一致する箇所を↑↓キーで追加。←で追加せずに次の箇所へ。→で取り消し(1つ戻る)
                          ;; (global-set-key (kbd "C-c m e") 'mc/mark-more-like-this-extended)
                          ;; ;; リージョンと一致する箇所全て追加
                          ;; (global-set-key (kbd "C-c m a") 'mc/mark-all-like-this)
                          ;; ;; 良い感じに追加
                          ;; (global-set-key (kbd "C-c m d") 'mc/mark-all-like-this-dwim)
                          ;; ;; HTML などで対応するタグを追加
                          ;; (global-set-key (kbd "C-c m t") 'mc/mark-sgml-tag-pair)
                          ;; → smartrep.el で設定
                          ))

          (:name smartrep.el-github
                 :type github
                 :url "git://github.com/myuhe/smartrep.el.git"
                 :after (progn
                          (require 'smartrep)
                          (smartrep-define-key
                              global-map "C-z" '(("c" . 'elscreen-create)
                                                 ("n" . 'elscreen-next)
                                                 ("p" . 'elscreen-previous)
                                                 ("a" . 'elscreen-toggle)
                                                 ("k" . 'elscreen-kill)
                                                 ))
                          ;; ("a" . (lambda () (beginning-of-buffer-other-window 0)))
                          ;; ("e" . (lambda () (end-of-buffer-other-window 0)))))

                          ;; multiple-cursors
                          (global-unset-key (kbd "C-c m"))
                          (smartrep-define-key global-map (kbd "C-c m")
                            '(("n"        . 'mc/mark-next-like-this)
                              ("p"        . 'mc/mark-previous-like-this)
                              ("m"        . 'mc/mark-more-like-this-extended)
                              ("u"        . 'mc/unmark-next-like-this)
                              ("U"        . 'mc/unmark-previous-like-this)
                              ("s"        . 'mc/skip-to-next-like-this)
                              ("S"        . 'mc/skip-to-previous-like-this)
                              ("*"        . 'mc/mark-all-like-this)
                              ("d"        . 'mc/mark-all-like-this-dwim)
                              ("i"        . 'mc/insert-numbers)
                              ("o"        . 'mc/sort-regions)
                              ("O"        . 'mc/reverse-regions)))

                          ))

          (:name clojure-mode-github
                 :type github
                 :url "git://github.com/technomancy/clojure-mode.git"
                 :after (progn

                          (require 'clojure-mode)
                          (add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))
                          (autoload 'clojure-mode "clojure-mode" "A major mode for Clojure" t)
                          ;; (setq inferior-lisp-program "lein repl")

                          ))

          (:name guide-key-github
                 :type github
                 :url "git://github.com/kbkbkbkb1/guide-key.git"
                 :after (progn

                          (require 'guide-key)
                          (setq guide-key/guide-key-sequence '("C-q" "C-c e" "C-c m" "C-c g" "C-q s" "C-c t" "C-c y" "C-x RET"))
                          ;; (setq guide-key/highlight-command-regexp "rectangle")
                          (guide-key-mode 1)  ; guide-key-mode を有効にする
                          ))

          (:name git-commit-mode-github
                 :type github
                 :url "https://github.com/rafl/git-commit-mode.git"
                 )


          (:name js2-mode-mooz-github
                 :type github
                 ;; :branch "emacs24"
                 :url "git://github.com/mooz/js2-mode.git"
                 :after (progn
                          (autoload 'js2-mode "js2-mode" nil t)
                          (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
                          ))

          (:name scala-mode2-github
                 :type github
                 :url "git://github.com/hvesalai/scala-mode2.git"
                 :after (progn
                          (require 'scala-mode2)
                          ))

          ;; (:name direx-el-github
          ;;        :type github
          ;;        :url "git://github.com/m2ym/direx-el.git"
          ;;        :after (progn
          ;;                 (require 'direx)
          ;;                 (require 'direx-project)

          ;;                 (defun my/dired-jump ()
          ;;                   (interactive)
          ;;                   (cond (current-prefix-arg
          ;;                          (dired-jump))
          ;;                         ((not (one-window-p))
          ;;                          (or (ignore-errors
          ;;                                (direx-project:jump-to-project-root) t)
          ;;                              (direx:jump-to-directory)))
          ;;                         (t
          ;;                          (or (ignore-errors
          ;;                                (direx-project:jump-to-project-root-other-window) t)
          ;;                              (direx:jump-to-directory-other-window)))))

          ;;                 (global-set-key (kbd "C-c d") 'my/dired-jump)

          ;;                 ;; → で toggle
          ;;                 (define-key direx:file-keymap (kbd "<right>") 'direx:toggle-item)
          ;;                 ;; vim 風
          ;;                 (define-key direx:file-keymap (kbd "l") 'direx:toggle-item)
          ;;                 (define-key direx:file-keymap (kbd "j") 'direx:next-item)
          ;;                 (define-key direx:file-keymap (kbd "k") 'direx:previous-item)
          ;;                 ;; o と f を入れ替え
          ;;                 (define-key direx:file-keymap (kbd "o") 'direx:find-item)
          ;;                 (define-key direx:file-keymap (kbd "f") 'direx:find-item-other-window)

          ;;                 ;; ツリーの表示
          ;;                 (setq direx:leaf-icon "  "
          ;;                       direx:open-icon "▾ "
          ;;                       direx:closed-icon "▸ ")

          ;;                 ;; popwin で開く
          ;;                 (push '(direx:direx-mode :position left :width 0.3 :dedicated t)
          ;;                       popwin:special-display-config)
          ;;                 ))

          (:name undo-tree-git
                 :type git
                 :url "http://www.dr-qubit.org/git/undo-tree.git"
                 :after (progn
                          (require 'undo-tree)
                          (global-undo-tree-mode)
                          ;; デフォルトで時間を表示
                          (setq undo-tree-visualizer-timestamps t)

                          (global-set-key (kbd "C-/") 'undo-tree-undo)
                          (global-set-key (kbd "M-/") 'undo-tree-redo)

                          ))


          ;; (:name nrepl.el.git-github
          ;;        :type github
          ;;        :url "git://github.com/kingtim/nrepl.el.git"
          ;;        :after (progn
          ;;                 (require 'nrepl)
          ;;                 (add-hook 'nrepl-interaction-mode-hook
          ;;                           'nrepl-turn-on-eldoc-mode)
          ;;                 ;; nrepl 用バッファをバッqファ一覧から隠す
          ;;                 (setq nrepl-hide-special-buffers t)
          ;;                 ;; エラーバッファのポップアップをしない
          ;;                 (setq nrepl-popup-stacktraces nil)
          ;;                 ;; C-c C-z switch to the *nrepl* buffer
          ;;                 (add-to-list 'same-window-buffer-names "*nrepl*")

          ;;                 ))

          (:name emacs-rotate-github
                 :type github
                 :url "git://github.com/daic-h/emacs-rotate.git"
                 :after (progn
                          (require 'rotate)
                          (global-set-key (kbd "C-q SPC") 'rotate-layout)
                          (global-set-key (kbd "C-c C-t") 'rotate-window)
                          ))

          (:name migemo-github
                 :type github
                 :url "git://github.com/emacs-jp/migemo.git"
                 :after (progn
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

                          ))

          (:name Highlight-Indentation-for-Emacs-github
                 :type github
                 :url "https://github.com/antonj/Highlight-Indentation-for-Emacs.git"
                 :after (progn
                          (require 'highlight-indentation)
                          (global-set-key (kbd "C-c i n") 'highlight-indentation-mode)
                          ))

          (:name emacs-anzu-github
                 :type github
                 :url "https://github.com/syohex/emacs-anzu.git"
                 :after (progn
                          (require 'anzu)
                          (global-anzu-mode)
                          ))

          (:name go-mode
                 :type http
                 :url "http://go.googlecode.com/hg/misc/emacs/go-mode.el?r=tip"
                 :localname "go-mode.el"
                 :after (progn
                          (require 'go-mode)

                          ;; go get code.google.com/p/rog-go/exp/cmd/godef
                          (add-hook 'go-mode-hook (lambda ()
                                                    (local-set-key (kbd "M-.") 'godef-jump)
                                                    (setq c-basic-offset 4)
                                                    (setq indent-tabs-mode t)
                                                    ;; 保存時に自動 fmt
                                                    (add-hook 'before-save-hook 'gofmt-before-save)

                                                    ;; GOPATH を Emacs から扱えるように exec-path へ追加しておくこと
                                                    (require 'go-autocomplete)
                                                    (require 'auto-complete-config)

                                                    (local-set-key (kbd "M-." 'godef-jump))
                                                    ;; (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
                                                    ;; (local-set-key (kbd "C-c i") 'go-goto-imports)
                                                    ;; (local-set-key (kbd "C-c d") 'godoc))
                                                    ))

                          ))

          ))



  (setq my-packages
        (append '(el-get) (mapcar 'el-get-source-name el-get-sources)))
  ;; (append '(el-get) (mapcar 'el-get-as-symbol (mapcar 'el-get-source-name el-get-sources))))
  (el-get 'sync my-packages)
  ;; (el-get 'wait)

  )
