(use-package dired
  :straight nil
  :bind (("C-x j" . dired-jump)
         ("C-x C-j" . dired-with-new-elscreen))
  :config
  (require 'dired-x)
  (require 'wdired)

  ;; フォルダを開く時, 新しいバッファを作成しない
  ;; バッファを作成したい時にはoやC-u ^を利用する
  (defvar my-dired-before-buffer nil)
  (defadvice dired-advertised-find-file
      (before kill-dired-buffer activate)
    (setq my-dired-before-buffer (current-buffer)))
  (defadvice dired-advertised-find-file
      (after kill-dired-buffer-after activate)
    (if (eq major-mode 'dired-mode)
        (kill-buffer my-dired-before-buffer)))
  (defadvice dired-up-directory
      (before kill-up-dired-buffer activate)
    (setq my-dired-before-buffer (current-buffer)))
  (defadvice dired-up-directory
      (after kill-up-dired-buffer-after activate)
    (if (eq major-mode 'dired-mode)
        (kill-buffer my-dired-before-buffer)))

  ;; ファイルなら別バッファで、ディレクトリなら同じバッファで開く
  (defun dired-open-in-accordance-with-situation ()
    (interactive)
    (let ((file (dired-get-filename)))
      (if (file-directory-p file)
          (dired-find-alternate-file)
        (dired-find-file))))

  ;; ;; dired-find-alternate-file の有効化
  ;; (put 'dired-find-alternate-file 'disabled nil)

  ;; フルパスファイル名コピー(ファイル名だけは"w")
  (defun dired-get-fullpath-filename ()
    "カーソル位置のファイル名 (フルパス) をコピー"
    (interactive)
    (kill-new (dired-get-filename))
    (message (dired-get-filename)))

  ;; dired を使って、一気にファイルの coding system (漢字) を変換する
  ;; m でマークして T で一括変換
  (require 'dired-aux)

  (defvar dired-default-file-coding-system nil
    "*Default coding system for converting file (s).")

  (defvar dired-file-coding-system 'no-conversion)

  (defun dired-convert-coding-system ()
    (let ((file (dired-get-filename))
          (coding-system-for-write dired-file-coding-system)
          failure)
      (condition-case err
          (with-temp-buffer
            (insert-file file)
            (write-region (point-min) (point-max) file))
        (error (setq failure err)))
      (if (not failure)
          nil
        (dired-log "convert coding system error for %s:\n%s\n" file failure)
        (dired-make-relative file))))

  (defun dired-do-convert-coding-system (coding-system &optional arg)
    "Convert file (s) in specified coding system."
    (interactive
     (list (let ((default (or dired-default-file-coding-system
                              buffer-file-coding-system)))
             (read-coding-system
              (format "Coding system for converting file (s) (default, %s): "
                      default)
              default))
           current-prefix-arg))
    (check-coding-system coding-system)
    (setq dired-file-coding-system coding-system)
    (dired-map-over-marks-check
     (function dired-convert-coding-system) arg 'convert-coding-system t))

  ;;   (use-package dired-filter)

  ;; dired のバッファ名末尾に [Dired] を追加する
  (defun dired-my-append-buffer-name-hint ()
    "Append a auxiliary string to a name of dired buffer."
    (when (eq major-mode 'dired-mode)
      (let* ((dir (expand-file-name list-buffers-directory))
             (drive (if (and (eq 'system-type 'windows-nt) ;; Windows の場合はドライブレターを追加
                             (string-match "^\\([a-zA-Z]:\\)/" dir))
                        (match-string 1 dir) "")))
        (rename-buffer (concat (buffer-name) " [" drive "Dired]") t))))
  (add-hook 'dired-mode-hook 'dired-my-append-buffer-name-hint)

  ;; ドットファイルなど優先度の低いファイルはデフォルトで非表示とする
  (add-hook 'dired-mode-hook
            'dired-omit-mode)

  (defun dired-find-file-other-exist-window ()
    "ウィンドウを再利用してもう片方のウィンドウで開く"
    (interactive)
    (find-file-other-exist-window (dired-get-file-for-visit)))

  (bind-keys :map dired-mode-map
             ("." . dired-omit-mode)
             ("f" . find-dired)
             ("o" . dired-find-file-other-exist-window)
             ("r" . wdired-change-to-wdired-mode)
             ("T" . dired-do-convert-coding-system)
             ("W" . dired-get-fullpath-filename)
             ;; ディレクトリの移動キーを追加(wdired 中は無効)
             ("<left>" . dired-up-directory)
             ;; ("<right>" . dired-find-file)
             ("<right>" . dired-open-in-accordance-with-situation)
             ("RET" . dired-open-in-accordance-with-situation)
             ("C-t" . other-window-or-split))

  )

;; ;;dired-sidebar
;; (use-package dired-sidebar
;;   :bind
;;   ("C-S-e" . dired-sidebar-toggle-sidebar)
;;   :commands (dired-sidebar-toggle-sidebar)
;;   :init
;;   (add-hook 'dired-sidebar-mode-hook
;;             (lambda ()
;;               (unless (file-remote-p default-directory)
;;                 (auto-revert-mode))))
;;   :config
;;   ;; (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
;;   ;; (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

;;   ;; 右端に表示する
;;   (setq dired-sidebar-display-alist '((side . right) (slot . -1)))
;;   ;; フォントサイズ
;;   (setq dired-sidebar-use-custom-font t)
;;   (setq dired-sidebar-face '(:height 90))
;;   ;; 横幅
;;   (setq dired-sidebar-width 45)
;;   ;; 左端からインデントを示す文字
;;   (setq dired-sidebar-subtree-line-prefix "  ")
;;   ;; 表示しているファイルに合わせてディレクトリを更新するか
;;   (setq dired-sidebar-should-follow-file nil)
;;   (setq dired-sidebar-theme 'icons)
;;   (setq dired-sidebar-use-term-integration t))
