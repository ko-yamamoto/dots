;;====================
;; For Mac
;;====================

(when is_mac

  ;; exec-pathとPATHに設定したいパスのリストを設定
  (dolist (dir (list
                "/usr/local/bin"
                "/usr/local/scala/bin"
                "~/bin"
                "/sbin"
                "/usr/sbin"
                "/bin"
                "/usr/bin"
                "/usr/local/ccl"
                "/usr/local/go/bin"
                "~/go/bin"
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


  ;; (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
  ;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


  ;; \の代わりにバックスラッシュを入力する
  (define-key global-map [165] [92])

  )


(when is_winnt
  (setq default-input-method "W32-IME")
  (setq-default w32-ime-mode-line-state-indicator "[--]")
  (setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
  (w32-ime-initialize)
  ;; 日本語入力時にカーソルの色を変える設定
  (add-hook 'w32-ime-on-hook '(lambda () (set-cursor-color "#d33682")))
  (add-hook 'w32-ime-off-hook '(lambda () (set-cursor-color "#4271ae")))
  )
