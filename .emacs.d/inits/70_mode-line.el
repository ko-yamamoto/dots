;; 改行文字の文字列表現
(set 'eol-mnemonic-dos "(CRLF)")
(set 'eol-mnemonic-unix "(LF)")
(set 'eol-mnemonic-mac "(CR)")
(set 'eol-mnemonic-undecided "(?)")


;; モードラインの文字エンコーディング表示をわかりやすくする - Qiita
;; https://qiita.com/kai2nenobu/items/ddf94c0e5a36919bc6db
;; 文字エンコーディングの文字列表現
(defun my-coding-system-name-mnemonic (coding-system)
  (let* ((base (coding-system-base coding-system))
         (name (symbol-name base)))
    (cond ((string-prefix-p "utf-8" name) "UTF8")
          ((string-prefix-p "utf-16" name) "UTF16")
          ((string-prefix-p "utf-7" name) "UTF7")
          ((string-prefix-p "japanese-shift-jis" name) "SJIS")
          ((string-match "cp\\([0-9]+\\)" name) (match-string 1 name))
          ((string-match "japanese-iso-8bit" name) "EUC")
          (t "???")
          )))

(defun my-coding-system-bom-mnemonic (coding-system)
  (let ((name (symbol-name coding-system)))
    (cond ((string-match "be-with-signature" name) "[BE]")
          ((string-match "le-with-signature" name) "[LE]")
          ((string-match "-with-signature" name) "[BOM]")
          (t ""))))

(defun my-buffer-coding-system-mnemonic ()
  "Return a mnemonic for `buffer-file-coding-system'."
  (let* ((code buffer-file-coding-system)
         (name (my-coding-system-name-mnemonic code))
         (bom (my-coding-system-bom-mnemonic code)))
    (format "%s%s" name bom)))

;; `mode-line-mule-info' の文字エンコーディングの文字列表現を差し替える
(setq-default mode-line-mule-info
              (cl-substitute '(:eval (my-buffer-coding-system-mnemonic))
                             "%z" mode-line-mule-info :test 'equal))


;; モードライン (mode-line-format)での書式記号
;; %b -- print buffer name.
;; %f -- print visited file name.
;; %F -- print frame name.
;; %* -- print %, * or hyphen.
;; %+ -- print *, % or hyphen.
;;       %& is like %*, but ignore read-only-ness.
;;       % means buffer is read-only and * means it is modified.
;;       For a modified read-only buffer, %* gives % and %+ gives *.
;; %s -- print process status.   %l -- print the current line number.
;; %c -- print the current column number (this makes editing slower).
;;       To make the column number update correctly in all cases,`column-number-mode' must be non-nil.
;; %i -- print the size of the buffer.
;; %I -- like %i, but use k, M, G, etc., to abbreviate.
;; %p -- print percent of buffer above top of window, or Top, Bot or All.
;; %P -- print percent of buffer above bottom of window, perhaps plus Top, or print Bottom or All.
;; %n -- print Narrow if appropriate.
;; %t -- visited file is text or binary (if OS supports this distinction).
;; %z -- print mnemonics of keyboard, terminal, and buffer coding systems.
;; %Z -- like %z, but including the end-of-line format.
;; %e -- print error message about full memory.
;; %@ -- print @ or hyphen.  @ means that default-directory is on a remote machine.
;; %[ -- print one [ for each recursive editing level.  %] similar.
;; %% -- print %.
;; %- -- print infinitely many dashes.

;; モードライン
(setq-default mode-line-format
              (list "%*[" 'mode-line-mule-info "] L%l:C%c %P [" `(vc-mode vc-mode) "]   %f   (%m" 'minor-mode-alist ")"))

(use-package powerline
  :disabled
  :config
  (setq powerline-default-separator 'wave) ;; arrow, slant, chamfer, wave, brace, roundstub, zigzag, butt, rounded, contour, curve
  (defun powerline-my-theme ()
    (interactive)
    (setq-default mode-line-format
                  '("%e"
                    (:eval
                     (let* ((active (powerline-selected-window-active))
                            (mode-line (if active 'mode-line 'mode-line-inactive))
                            (face1 (if active 'powerline-active1 'powerline-inactive1))
                            (face2 (if active 'powerline-active2 'powerline-inactive2))
                            (separator-left (intern (format "powerline-%s-%s"
                                                            (powerline-current-separator)
                                                            (car powerline-default-separator-dir))))
                            (separator-right (intern (format "powerline-%s-%s"
                                                             (powerline-current-separator)
                                                             (cdr powerline-default-separator-dir))))
                            (lhs (list (powerline-raw "%*" face1 'l)
                                       (when powerline-display-mule-info
                                         (powerline-raw mode-line-mule-info face1 'r))
                                       (funcall separator-left face1 face2)
                                       (powerline-major-mode face2 'l)
                                       (when (and (boundp 'which-func-mode) which-func-mode)
                                         (powerline-raw which-func-format face2 'l))
                                       (powerline-raw " " face2 'l)
                                       (powerline-vc face2 'r)
                                       (funcall separator-left face2 mode-line)
                                       (powerline-raw "%b" nil 'l)
                                       ))
                            (rhs (list (unless window-system
                                         (powerline-raw (char-to-string #xe0a1) nil 'l))
                                       (funcall separator-right mode-line face2)
                                       (powerline-raw "%4l" face2 'l)
                                       (powerline-raw ":" face2 'l)
                                       (powerline-raw "%3c" face2 'r)
                                       (powerline-raw "%6p" face2 'r)
                                       (funcall separator-right face2 face1)
                                       (powerline-raw " " face1 'r)
                                       (when powerline-display-buffer-size
                                         (powerline-buffer-size face1 'r)))))
                       (concat (powerline-render lhs)
                               (powerline-fill nil (powerline-width rhs))
                               (powerline-render rhs)))))))
  (powerline-my-theme)
  )


(use-package doom-modeline
  :custom
  (doom-modeline-buffer-file-name-style 'truncate-with-project)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon nil)
  (doom-modeline-minor-modes nil)
  :hook
  (after-init . doom-modeline-mode)
  :config
  ;; (line-number-mode 0)
  (column-number-mode 0)
  (doom-modeline-def-modeline 'main
    '(bar workspace-number window-number evil-state god-state ryo-modal xah-fly-keys matches buffer-info remote-host buffer-position parrot selection-info)
    '(misc-info persp-name lsp github debug minor-modes input-method buffer-encoding major-mode process vcs checker)))

(use-package hide-mode-line
  :hook
  ((neotree-mode imenu-list-minor-mode minimap-mode) . hide-mode-line-mode))

