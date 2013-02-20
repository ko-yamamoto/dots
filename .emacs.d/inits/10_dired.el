;;====================
;; Dired
;;====================
;; dired-x
(require 'dired-x)
;; Cygwin 利用時
(setq dired-guess-shell-gnutar "tar")
;; 以下，各ファイル別の設定
(setq dired-guess-shell-alist-user
      '(("\\.tar\\.gz\\'"  "tar ztvf")
        ("\\.taz\\'" "tar ztvf")
        ("\\.tar\\.bz2\\'" "tar Itvf")
        ("\\.zip\\'" "unzip -l")
        ("\\.\\(g\\|\\) z\\'" "zcat")
        ("\\.\\(jpg\\|JPG\\|gif\\|GIF\\)\\'"
         (if (eq system-type 'windows-nt)
             "fiber" "xv"))
        ("\\.ps\\'"
         (if (eq system-type 'windows-nt)
             "fiber" "ghostview"))
        ))

;; wdired
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; 並び替えのキー
(defvar dired-various-sort-type
  '(("S" . "size")
    ("X" . "extension")
    ("v" . "version")
    ("t" . "date")
    (""  . "name")))

;; dired
(defun dired-various-sort-change (sort-type-alist &optional prior-pair)
  (when (eq major-mode 'dired-mode)
    (let* (case-fold-search
           get-next
           (options
            (mapconcat 'car sort-type-alist ""))
           (opt-desc-pair
            (or prior-pair
                (catch 'found
                  (dolist (pair sort-type-alist)
                    (when get-next
                      (throw 'found pair))
                    (setq get-next (string-match (car pair) dired-actual-switches)))
                  (car sort-type-alist)))))
      (setq dired-actual-switches
            (concat "-l" (dired-replace-in-string (concat "[l" options "-]")
                                                  ""
                                                  dired-actual-switches)
                    (car opt-desc-pair)))
      (setq mode-name
            (concat "Dired by " (cdr opt-desc-pair)))
      (force-mode-line-update)
      (revert-buffer))))

(defun dired-various-sort-change-or-edit (&optional arg)
  "Hehe"
  (interactive "P")
  (when dired-sort-inhibit
    (error "Cannot sort this dired buffer"))
  (if arg
      (dired-sort-other
       (read-string "ls switches (must contain -l): " dired-actual-switches))
    (dired-various-sort-change dired-various-sort-type)))

(defvar helm-c-source-dired-various-sort
  '((name . "Dired various sort type")
    (candidates . (lambda ()
                    (mapcar (lambda (x)
                              (cons (concat (cdr x) " (" (car x) ")") x))
                            dired-various-sort-type)))
    (action . (("Set sort type" . (lambda (candidate)
                                    (dired-various-sort-change dired-various-sort-type candidate)))))
    ))


(add-hook 'dired-mode-hook
          '(lambda ()
             (define-key dired-mode-map "s" 'dired-various-sort-change-or-edit)
             (define-key dired-mode-map "c"
               '(lambda ()
                  (interactive)
                  (helm '(helm-c-source-dired-various-sort))))
             ))


;; diredでマークをつけたファイルをfind/view
(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map "F" 'my-dired-find-file)
     (defun my-dired-find-file (&optional arg)
       "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
       (interactive "P")
       (let* ((fn-list (dired-get-marked-files nil arg)))
         (mapc 'find-file fn-list)))
     (define-key dired-mode-map "V" 'my-dired-view-file)
     (defun my-dired-view-file (&optional arg)
       "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
       (interactive "P")
       (let* ((fn-list (dired-get-marked-files nil arg)))
         (mapc 'view-file fn-list)))))


;; diredでのファイルコピーを便利に
(setq dired-dwim-target t)


;;; フォルダを開く時, 新しいバッファを作成しない
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

;; dired-find-alternate-file の有効化
(put 'dired-find-alternate-file 'disabled nil)
;; RET 標準の dired-find-file では dired バッファが複数作られるので
;; dired-find-alternate-file を代わりに使う
(define-key dired-mode-map (kbd "RET") 'dired-open-in-accordance-with-situation)
(define-key dired-mode-map (kbd "a") 'dired-find-file)


;; ディレクトリの移動キーを追加(wdired 中は無効)
(define-key dired-mode-map (kbd "<left>") 'dired-up-directory)
(define-key dired-mode-map (kbd "<right>") 'dired-open-in-accordance-with-situation)


;; フルパスファイル名コピー(ファイル名だけは"w")
(defun dired-get-fullpath-filename ()
  "カーソル位置のファイル名 (フルパス) をコピー"
  (interactive)
  (kill-new (dired-get-filename))
  (message (dired-get-filename)))
(define-key dired-mode-map (kbd "W") 'dired-get-fullpath-filename)



;; Quick Look
(setq dired-load-hook '(lambda () (load "dired-x")))
(setq dired-guess-shell-alist-user
      '(("\\.png" "qlmanage -p")
        ("\\.jpg" "qlmanage -p")
        ("\\.pdf" "qlmanage -p")))

;; popwinでdiredを開くときのキー
;; (global-set-key (kbd "C-c d") 'dired-jump-other-window)


;; dired から外部プログラムで開くための設定
(defun open-file-dwim (filename)
  "Open file dwim"
  (let* ((winp (string-equal window-system "w32"))
         (opener (if (file-directory-p filename)
                     (if winp '("explorer.exe") '("open"))
                   (if winp '("cygstart.exe") '("open"))))
         (fn (replace-regexp-in-string "/$" "" filename))
         (args (append opener (list (if winp
                                        (replace-regexp-in-string "/" (rx "\\") fn)
                                      fn))))
         (process-connection-type nil))
    (apply 'start-process "open-file-dwim" nil args)))

;; カーソル下のファイルやディレクトリを関連付けられたプログラムで開く
(defun dired-open-dwim ()
  "Open file under the cursor"
  (interactive)
  (open-file-dwim (dired-get-filename)))

;; 現在のディレクトリを関連付けられたプログラムで開く
(defun dired-open-here ()
  "Open current directory"
  (interactive)
  (open-file-dwim (expand-file-name dired-directory)))

;; キーバインド
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map (kbd "C-c o") 'dired-open-dwim)
            (define-key dired-mode-map (kbd "C-c .") 'dired-open-here)
            ))


;; helm in dired
(defun my/helm-dired ()
  (interactive)
  (let ((curbuf (current-buffer)))
    (if (helm-other-buffer
         '(helm-c-source-files-in-current-dir)
         "*helm-dired*")
        (kill-buffer curbuf))))
(define-key dired-mode-map (kbd "p") 'my/helm-dired)

(define-key dired-mode-map (kbd "f") 'find-dired)

;; Dired バッファに [Dired] を追加する
(defun dired-my-append-buffer-name-hint ()
  "Append a auxiliary string to a name of dired buffer."
  (when (eq major-mode 'dired-mode)
    (let* ((dir (expand-file-name list-buffers-directory))
           (drive (if (and (eq 'system-type 'windows-nt) ;; Windows の場合はドライブレターを追加
                           (string-match "^\\([a-zA-Z]:\\)/" dir))
                      (match-string 1 dir) "")))
      (rename-buffer (concat (buffer-name) " [" drive "Dired]") t))))
(add-hook 'dired-mode-hook 'dired-my-append-buffer-name-hint)


;;; dired を使って、一気にファイルの coding system (漢字) を変換する
;; m でマークして T で一括変換
(require 'dired-aux)
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key (current-local-map) "T"
              'dired-do-convert-coding-system)))

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




;; dired でのファイルサイズ表示のオプション
(setq dired-listing-switches "-FlhA")




;; diredの隠しファイル表示をトグルするminor-mode
(defvar dired-list-all-switch "-A"
  "Switch for listing dot files.
Should be \"-a\" or \"-A\". Additional switch can be included.")

(define-minor-mode dired-list-all-mode
  "Toggle whether list dot files in dired.
When using this mode the value of `dired-listing-switches' should not contain \"-a\" or \"-A\" option."
  :init-value nil
  :global nil
  :lighter " ALL"
  (when (eq major-mode 'dired-mode)
    (dired-list-all-set)
    (revert-buffer)))

(defun dired-list-all-set ()
  ""
  (if dired-list-all-mode
      (or (string-match-p dired-list-all-switch
                          dired-actual-switches)
          (setq dired-actual-switches
                (concat dired-list-all-switch
                        " "
                        dired-actual-switches)))
    (setq dired-actual-switches
          (replace-regexp-in-string (concat dired-list-all-switch
                                            " ")
                                    ""
                                    dired-actual-switches))))
(add-hook 'dired-mode-hook
          'dired-list-all-set)
(provide 'dired-list-all-mode)
;; a で dired の隠しファイル表示をトグル
(when (require 'dired-list-all-mode nil t)
  (setq dired-listing-switches "-lhFG")
  (add-hook 'dired-mode-hook
            (lambda ()
              (define-key dired-mode-map "a" 'dired-list-all-mode)
              )))


(defun dired-find-file-other-exist-window ()
  "ウィンドウを再利用してもう片方のウィンドウで開く"
  (interactive)
  (find-file-other-exist-window (dired-get-file-for-visit)))
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "o" 'dired-find-file-other-exist-window)
            ))
