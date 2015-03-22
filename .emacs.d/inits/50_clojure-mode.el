(use-package clojure-mode
  :ensure t
  :defer t
  :config

  (use-package clojure-mode-extra-font-locking :ensure t)
  (use-package cider :ensure t)

  (add-hook 'clojure-mode-hook 'cider-mode)

  ;; mini bufferに関数の引数を表示させる
  (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

  ;; 'C-x b' した時に *nrepl-connection* と *nrepl-server* のbufferを一覧に表示しない
  (setq nrepl-hide-special-buffers t)

  ;; RELPのbuffer名を 'project名:nREPLのport番号' と表示する
  ;; project名は project.clj で defproject した名前
  (setq nrepl-buffer-name-show-port t)

  ;; Compojure 用
  (add-hook 'clojure-mode-hook
            (lambda()
              (define-clojure-indent
                (defroutes 'defun)
                (GET 2)
                (POST 2)
                (PUT 2)
                (DELETE 2)
                (HEAD 2)
                (ANY 2)
                (context 2))))

  (use-package ac-cider
    :ensure t
    :config
    ;; (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
    (add-hook 'cider-mode-hook 'ac-cider-setup)
    (add-hook 'cider-repl-mode-hook 'ac-cider-setup)
    (add-to-list 'ac-modes 'cider-mode)
    (add-to-list 'ac-modes 'cider-repl-mode))

  )
