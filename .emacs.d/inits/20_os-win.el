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
                "C:/Program Files (x86)/Git/bin"
                (expand-file-name "~/bin")
                (expand-file-name "~/.emacs.d/bin")
                ))
    ;; PATH と exec-path に同じ物を追加
    (when (and (file-exists-p dir) (not (member dir exec-path)))
      (setenv "PATH" (concat dir ":" (getenv "PATH")))
      (setq exec-path (append (list dir) exec-path))))

    ;; ファイル名の文字コード指定
    (setq file-name-coding-system 'shift_jis)


)

