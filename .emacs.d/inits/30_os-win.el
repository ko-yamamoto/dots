;; ---------------------------------------------------------------------------------
;; OS Settings
;; ---------------------------------------------------------------------------------

;;====================
;; For Win
;;====================

(when is_win

  ;; exec-pathとPATHに設定したいパスのリストを設定
  (dolist (dir (list
                "C:/scala/scala/bin"
                "C:/Python27"
                "C:/java/jdk1.7.0/bin"
                (expand-file-name "~/bin")
                (expand-file-name "~/.emacs.d/bin")
                ))
    ;; PATH と exec-path に同じ物を追加
    (when (and (file-exists-p dir) (not (member dir exec-path)))
      (setenv "PATH" (concat dir ":" (getenv "PATH")))
      (setq exec-path (append (list dir) exec-path))))

    ;; ファイル名の文字コード指定
    ;; (setq file-name-coding-system 'shift_jis)

    ;; "Emacs 23.1.50.1 hangs ramdomly for 6-8 seconds on Windows XP - Stack Overflow"
    ;; http://stackoverflow.com/questions/2007329/emacs-23-1-50-1-hangs-ramdomly-for-6-8-seconds-on-windows-xp
    ;; (setq w32-get-true-file-attributes nil)


)

