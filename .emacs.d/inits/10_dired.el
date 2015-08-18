;; ;;====================
;; ;; Dired
;; ;;====================
(use-package dired
  :defer t
  :bind (("C-x C-j" . dired-jump)
         ("C-x j" . dired-with-new-elscreen))
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

  ;; dired-find-alternate-file の有効化
  (put 'dired-find-alternate-file 'disabled nil)

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
  (require 'dired-list-all-mode nil t)
  (setq dired-listing-switches "-lhFG")

  ;;   (use-package dired-filter :ensure)

  (bind-keys :map dired-mode-map
             ("a" . dired-list-all-mode)
             ("f" . find-dired)
             ("o" . dired-find-file-other-exist-window)
             ("r" . wdired-change-to-wdired-mode)
             ("T" . dired-do-convert-coding-system)
             ("W" . dired-get-fullpath-filename)
             ;; ディレクトリの移動キーを追加(wdired 中は無効)
             ("<left>" . dired-up-directory)
             ("<right>" . dired-open-in-accordance-with-situation)
             ("RET" . dired-open-in-accordance-with-situation)
             ("C-t" . other-window-or-split))
  )
