(use-package popwin
  :ensure t
  :defer t
  :config
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
                  (direx:direx-mode :position left :width 0.3)
                  ("*auto-async-byte-compile*" :height 20)
                  ("*Shell Command Output*" :height 25)
                  ("*svn output*" :stick t :position right)
                  ("\\*nrepl-*" :height 0.3 :regexp t)
                  )
                popwin:special-display-config))
  )
