;; ;;====================
;; ;; Eshell
;; ;;====================
;; ;; @see launch setting

;; ;; 補完時に大文字小文字を区別しない
;; (setq eshell-cmpl-ignore-case t)
;; ;; 確認なしでヒストリ保存
;; (setq eshell-ask-to-save-history (quote always))
;; ;; 補完時にサイクルする
;; ;;(setq eshell-cmpl-cycle-completions t)
;; (setq eshell-cmpl-cycle-completions nil)
;; ;;補完候補がこの数値以下だとサイクルせずに候補表示
;; (setq eshell-cmpl-cycle-cutoff-length 5)
;; ;; 履歴で重複を無視する
;; (setq eshell-hist-ignoredups t)
;; prompt 文字列の変更
(defun my-eshell-prompt ()
  (concat (eshell/pwd) "\n♪ " ))
(setq eshell-prompt-function 'my-eshell-prompt)
(setq eshell-prompt-regexp "^[^#$\n]*[#♪] ")


;; ;; sudoのあとも補完可能に
;; (defun pcomplete/sudo ()
;;   "Completion rules for the `sudo' command."
;;   (let ((pcomplete-help "complete after sudo"))
;;     (pcomplete-here (pcomplete-here (eshell-complete-commands-list)))))

;; ;; トグルする設定
;; (defun my-toggle-term ()
;;   "eshell と直前のバッファを行き来する。C-u 付きで呼ぶと 今いるバッファと同じディレクトリに cd して開く"
;;   (interactive)
;;   (let ((ignore-list '("*Help*" "*Minibuf-1*" "*Messages*" "*Completions*"
;;                        "*terminal<1>*" "*terminal<2>*" "*terminal<3>*"))
;;         (dir default-directory))
;;     (labels
;;         ((_my-toggle-term (target)
;;                           (if (null (member (buffer-name (second target)) ignore-list))
;;                               (if (equal "*eshell*" (buffer-name (window-buffer)))
;;                                   (switch-to-buffer (second target))
;;                                 (switch-to-buffer "*eshell*")
;;                                 (when current-prefix-arg
;;                                   (cd dir)
;;                                   (eshell-interactive-print (concat "cd " dir "\n"))
;;                                   (eshell-emit-prompt)))
;;                             (_my-toggle-term (cdr target)))))
;;       (_my-toggle-term (buffer-list)))))
;; (global-set-key (kbd "C-t") 'my-toggle-term)

;; eshell での補完に auto-complete.el を使う
(require 'pcomplete)
(add-to-list 'ac-modes 'eshell-mode)
(ac-define-source pcomplete
  '((candidates . pcomplete-completions)))
(defun my-ac-eshell-mode ()
  (setq ac-sources
        '(ac-source-pcomplete
          ac-source-filename
          ac-source-files-in-current-dir
          ac-source-words-in-buffer
          ac-source-dictionary)))
(add-hook 'eshell-mode-hook
          (lambda ()
            (my-ac-eshell-mode)
            (define-key eshell-mode-map (kbd "C-i") 'auto-complete)
            (define-key eshell-mode-map [(tab)] 'auto-complete)))

;; ;; キーバインドの変更
;; (add-hook 'eshell-mode-hook
;;           '(lambda ()
;;              (progn
;;                (define-key eshell-mode-map (kbd "C-a") 'eshell-bol)
;;                (define-key eshell-mode-map [up] 'eshell-previous-matching-input-from-input)
;;                (define-key eshell-mode-map [down] 'eshell-next-matching-input-from-input)
;;                (define-key eshell-mode-map (kbd "C-p") 'previous-line)
;;                (define-key eshell-mode-map (kbd "C-n") 'next-line)
;;                )
;;              ))

;; ;; aliasの設定
;; (eval-after-load "em-alias"
;;   '(progn (eshell/alias "ll" "ls -alh")
;;           (eshell/alias "ec" "emacsclient -n")))


;; ;; lsのリストからディレクトリを開く
;; ;;; From: http://www.emacswiki.org/cgi-bin/wiki.pl/EshellEnhancedLS
;; (eval-after-load "em-ls"
;;   '(progn
;;      ;; (defun ted-eshell-ls-find-file-at-point (point)
;;      ;;          "RET on Eshell's `ls' output to open files."
;;      ;;          (interactive "d")
;;      ;;          (find-file (buffer-substring-no-properties
;;      ;;                      (previous-single-property-change point 'help-echo)
;;      ;;                      (next-single-property-change point 'help-echo))))
;;      (defun pat-eshell-ls-find-file-at-mouse-click (event)
;;        "Middle click on Eshell's `ls' output to open files.
;;  From Patrick Anderson via the wiki."
;;        (interactive "e")
;;        (ted-eshell-ls-find-file-at-point (posn-point (event-end event))))
;;      (defun ted-eshell-ls-find-file ()
;;        (interactive)
;;        (let ((fname (buffer-substring-no-properties
;;                      (previous-single-property-change (point) 'help-echo)
;;                      (next-single-property-change (point) 'help-echo))))
;;          ;; Remove any leading whitespace, including newline that might
;;          ;; be fetched by buffer-substring-no-properties
;;          (setq fname (replace-regexp-in-string "^[ \t\n]*" "" fname))
;;          ;; Same for trailing whitespace and newline
;;          (setq fname (replace-regexp-in-string "[ \t\n]*$" "" fname))
;;          (cond
;;           ((equal "" fname)
;;            (message "No file name found at point"))
;;           (fname
;;            (find-file fname)))))
;;      (let ((map (make-sparse-keymap)))
;;        ;;          (define-key map (kbd "RET")      'ted-eshell-ls-find-file-at-point)
;;        ;;          (define-key map (kbd "<return>") 'ted-eshell-ls-find-file-at-point)
;;        (define-key map (kbd "RET")      'ted-eshell-ls-find-file)
;;        (define-key map (kbd "<return>") 'ted-eshell-ls-find-file)
;;        (define-key map (kbd "<mouse-2>") 'pat-eshell-ls-find-file-at-mouse-click)
;;        (defvar ted-eshell-ls-keymap map))
;;      (defadvice eshell-ls-decorated-name (after ted-electrify-ls activate)
;;        "Eshell's `ls' now lets you click or RET on file names to open them."
;;        (add-text-properties 0 (length ad-return-value)
;;                             (list 'help-echo "RET, mouse-2: visit this file"
;;                                   'mouse-face 'highlight
;;                                   'keymap ted-eshell-ls-keymap)
;;                             ad-return-value)
;;        ad-return-value)))


(defun eshell-with-new-elscreen ()
  "新しい elscreen で eshell"
  (interactive)
  (elscreen-create)
  (eshell))
(global-set-key (kbd "C-q e") 'eshell-with-new-elscreen)
