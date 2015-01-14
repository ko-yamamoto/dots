(use-package git-gutter+
  :ensure t
  :bind (("C-c g c" . git-gutter:toggle))
  :config
  (global-git-gutter+-mode t) ;; el-get が誤作動するため global は使わない
  ;; ;; 指定したモードで有効に
  ;; (let ((mode-hooks
  ;;        '(emacs-lisp-mode-hook
  ;;          org-mode-hook
  ;;          rst-mode-hook
  ;;          java-mode-hook
  ;;          lisp-mode-hook
  ;;          clojure-mode-hook
  ;;          scala-mode-hook
  ;;          haskell-mode-hook
  ;;          sh-mode-hook
  ;;          go-mode-hook
  ;;          python-mode-hook
  ;;          ruby-mode-hook)))
  ;;   (mapcar (lambda (mode-hook) (add-hook mode-hook 'git-gutter-mode)) mode-hooks))

  ;; 表示変更
  (setq git-gutter+-window-width 1)
  (setq git-gutter+-modified-sign "|")
  (setq git-gutter+-added-sign "|")
  (setq git-gutter+-deleted-sign "|")

  ;; 色変更
  (set-face-foreground 'git-gutter+-modified "#eab700")
  (set-face-foreground 'git-gutter+-added "#95D9FF")
  (set-face-foreground 'git-gutter+-deleted "#c82829")

  ;; Ignore all spaces
  (setq git-gutter+-diff-options '("-w"))
  )


(use-package git-gutter-fringe+
  :ensure t
  :config
  (setq-default left-fringe-width  10)
  (setq-default right-fringe-width 10)
  ;; 形変更 (上下くっつけるため目一杯長く)
  (fringe-helper-define 'git-gutter-fr+-added nil
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX")
  (fringe-helper-define 'git-gutter-fr+-deleted nil
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX")
  (fringe-helper-define 'git-gutter-fr+-modified nil
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX"
                        "XXXXXXXXX")

  )
