;;;;;;;;;;;;;; NTFS シンボリックリンクを含むファイルを削除しようとするとフリーズする対策
(setq-default find-file-visit-truename t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mozc
(require 'mozc-im)
(require 'mozc-popup)
(require 'mozc-cursor-color)

(setq default-input-method "japanese-mozc-im")

;; popupスタイル を使用する
(setq mozc-candidate-style 'popup)

;; Windows 側の Google 日本語入力との連携
(setq mozc-helper-program-name "mozc_emacs_helper.sh")

;; カーソルカラーを設定する
(setq mozc-cursor-color-alist '((direct        . "#C678DD")
                                (read-only     . "#F39C12")
                                (hiragana      . "#99cc99")
                                (full-katakana . "goldenrod")
                                (half-ascii    . "dark orchid")
                                (full-ascii    . "orchid")
                                (half-katakana . "dark goldenrod")))


;; mozc-cursor-color を利用するための対策
;; (defvar mozc-im-mode nil)
;; (make-variable-buffer-local 'mozc-im-mode)
(defvar-local mozc-im-mode nil)
(add-hook 'mozc-im-activate-hook (lambda () (setq mozc-im-mode t)))
(add-hook 'mozc-im-deactivate-hook (lambda () (setq mozc-im-mode nil)))
(advice-add 'mozc-cursor-color-update
            :around (lambda (orig-fun &rest args)
                      (let ((mozc-mode mozc-im-mode))
                        (apply orig-fun args))))

;; isearch を利用する前後で IME の状態を維持するための対策
(add-hook 'isearch-mode-hook (lambda () (setq im-state mozc-im-mode)))
(add-hook 'isearch-mode-end-hook
          (lambda ()
            (unless (eq im-state mozc-im-mode)
              (if im-state
                  (activate-input-method default-input-method)
                (deactivate-input-method)))))

;; wdired 終了時に IME を OFF にする
(require 'wdired)
(advice-add 'wdired-finish-edit
            :after (lambda (&rest args)
                     (deactivate-input-method)))

;; Windows の mozc では、セッション接続直後 directモード になるので hiraganaモード にする
(advice-add 'mozc-session-execute-command
            :after (lambda (&rest args)
                     (when (eq (nth 0 args) 'CreateSession)
                       (mozc-session-sendkey '(henkan))) ; Google 日本語入力をオンにするキー
                     (when (eq (nth 0 args) 'DeleteSession)
                       (mozc-session-sendkey '(muhenkan))) ; Google 日本語入力をオフにするキー
                     ))

;; 変換キーでon
(global-set-key [henkan]
                (lambda () (interactive)
                  (mozc-mode 1)
                  (when (null current-input-method) (toggle-input-method))))
;; 無変換キーでon
(global-set-key [muhenkan]
                (lambda () (interactive)
                  (mozc-mode nil)
                  (deactivate-input-method)
                  ;; (mozc-session-sendkey '(muhenkan))
                  ;; (mozc-session-delete)
                  ))


;; for helm ;;;;;;;;;;;;;;;;;;;;
(require 'cl-lib)

;; helm でミニバッファの入力時に IME の状態を継承しない
(setq helm-inherit-input-method nil)

;; helm の検索パターンを mozc を使って入力した場合にエラーが発生することがあるのを改善する
(advice-add 'mozc-helper-process-recv-response
            :around (lambda (orig-fun &rest args)
                      (cl-loop for return-value = (apply orig-fun args)
                               if return-value return it)))

;; helm の検索パターンを mozc を使って入力する場合、入力中は helm の候補の更新を停止する
(advice-add 'mozc-candidate-dispatch
            :before (lambda (&rest args)
                      (when helm-alive-p
                          (cl-case (nth 0 args)
                            ('update
                             (unless helm-suspend-update-flag
                               (helm-kill-async-processes)
                               (setq helm-pattern "")
                               (setq helm-suspend-update-flag t)))
                            ('clean-up
                             (when helm-suspend-update-flag
                               (setq helm-suspend-update-flag nil)))))))

;; helm で候補のアクションを表示する際に IME を OFF にする
(advice-add 'helm-select-action
            :before (lambda (&rest args)
                      (deactivate-input-method)))

;; for md ;;;;;;;;;
(use-package markdown-mode
  :config
  (bind-keys :map mozc-mode-map
             ("M-x" . helm-M-x)))


;;;;;;;;;;; Windowsパス と UNCパス を使えるようにするための設定
(defun set-drvfs-alist ()
  (mapcar (lambda (x) (split-string x "|"))
          (delete "" (split-string
                      (shell-command-to-string
                       "mount | grep 'type drvfs' | sed -r 's/(.*) on (.*) type drvfs .*/\\2\\|\\1/' | sed 's!\\\\!/!g'")
                      "\n"))))

(defvar drvfs-alist (set-drvfs-alist))
(defconst windows-path-style-regexp "\\`\\(.*/\\)?\\([a-zA-Z]:\\\\.*\\|[a-zA-Z]:/.*\\|\\\\\\\\.*\\|//.*\\)")

(defun windows-path-convert-file-name (name)
  (setq name (replace-regexp-in-string windows-path-style-regexp "\\2" name t nil))
  (setq name (replace-regexp-in-string "\\\\" "/" name))
  (mapc (lambda (x)
          (setq name (replace-regexp-in-string
                      (concat "^" (regexp-quote (nth 1 x))) (nth 0 x) name t)))
        drvfs-alist)
  name)

(defun windows-path-run-real-handler (operation args)
  "Run OPERATION with ARGS."
  (let ((inhibit-file-name-handlers
         (append '(windows-path-map-drive-hook-function)
                 (and (eq inhibit-file-name-operation operation)
                      inhibit-file-name-handlers)))
        (inhibit-file-name-operation operation))
    (apply operation args)))

(defun windows-path-map-drive-hook-function (operation name &rest args)
  "Run OPERATION on cygwin NAME with ARGS."
  (windows-path-run-real-handler
   operation
   (cons (windows-path-convert-file-name name)
         (if (stringp (car args))
             (cons (windows-path-convert-file-name (car args))
                   (cdr args))
           args))))

(add-to-list 'file-name-handler-alist
             (cons windows-path-style-regexp
                   'windows-path-map-drive-hook-function))



;;;;;;;;;;;;;;;;;; ブラウザは Windows 側の Chrome を起動する
;; make ~/bin/open-chrome
;; #!/bin/sh
;; exec /mnt/c/Program\ Files\ \(x86\)/Google/Chrome\ Beta/Application/chrome.exe "$@"
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "open-chrome")


;;;;;;;;;;;;;;;;;; C-d に delete-selection-mod が効かないので無理やり
(global-set-key (kbd "C-d") 'delete-forward-char)


;;;;;;;;;;;;;;;;;; tramp
(setq tramp-default-method "scpx")
;; Emacs: Windowsでやっていく2017 | 葉月夜堂 https://yo.eki.do/notes/emacs-windows-2017
(custom-set-variables '(tramp-chunksize 1024))
