;; prompt 文字列の変更
(defun my-eshell-prompt ()
  (concat (eshell/pwd) "\n♪ " ))
(setq eshell-prompt-function 'my-eshell-prompt)
(setq eshell-prompt-regexp "^[^#$\n]*[#♪] ")


;; ;; eshell での補完に auto-complete.el を使う
;; (require 'pcomplete)
;; (add-to-list 'ac-modes 'eshell-mode)
;; (ac-define-source pcomplete
;;   '((candidates . pcomplete-completions)))
;; (defun my-ac-eshell-mode ()
;;   (setq ac-sources
;;         '(ac-source-pcomplete
;;           ac-source-filename
;;           ac-source-files-in-current-dir
;;           ac-source-words-in-buffer
;;           ac-source-dictionary)))
;; (add-hook 'eshell-mode-hook
;;           (lambda ()
;;             (my-ac-eshell-mode)
;;             (define-key eshell-mode-map (kbd "C-i") 'auto-complete)
;;             (define-key eshell-mode-map [(tab)] 'auto-complete)
;;             ))

;; eshell での補完に pcomplete を使う
;; 補完時に大文字小文字を区別しない
(setq eshell-cmpl-ignore-case t)
;; 確認なしでヒストリ保存
(setq eshell-ask-to-save-history (quote always))
;; 補完時にサイクルする
(setq eshell-cmpl-cycle-completions t)
;; (setq eshell-cmpl-cycle-completions nil)
;;補完候補がこの数値以下だとサイクルせずに候補表示
(setq eshell-cmpl-cycle-cutoff-length 1)
;; 履歴で重複を無視する
(setq eshell-hist-ignoredups t)




;; eshell 起動
(global-set-key (kbd "C-c e e") 'eshell)


;; helm で履歴から入力
(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map
                (kbd "M-p")
                'helm-eshell-history)))

;; helm で補完
(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map [(tab)] 'helm-esh-pcomplete)))

;; helm で pcomplete と履歴の補完を同時に
;; (add-hook 'eshell-mode-hook
;;           #'(lambda ()
;;               (require 'helm-eshell)
;;               (defun my-helm-eshell ()
;;                 (interactive)
;;                 (helm-other-buffer '(helm-c-source-esh
;;                                      helm-c-source-eshell-history)
;;                                    "my helm eshell"))
;;               (define-key eshell-mode-map [(tab)] 'my-helm-eshell)
;;               ))


;; ちょっと作業用
(require 'popwin)
(defvar eshell-pop-buffer "*eshell-pop*")
(defvar eshell-prev-buffer nil)
(defun eshell-pop ()
  (interactive)
  (setq eshell-prev-buffer (current-buffer))
  (unless (get-buffer eshell-pop-buffer)
    (save-window-excursion
      (pop-to-buffer (get-buffer-create eshell-pop-buffer))
      (eshell-mode)))
  (popwin:popup-buffer (get-buffer eshell-pop-buffer) :height 20))
(global-set-key (kbd "C-c e p") 'eshell-pop)

;; eshell のバッファはカーソルが一番下までいっても良い
(add-hook 'eshell-mode-hook
          (lambda ()
            (make-local-variable 'scroll-margin)
            (setq scroll-margin 0)))


;; function ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; eshell 起動してバッファのディレクトリへ移動
(defun eshell/cde ()
  (let* ((file-name (buffer-file-name eshell-prev-buffer))
         (dir (or (and file-name (file-name-directory file-name))
                  (and (eq major-mode 'dired-mode) dired-directory)
                  (with-current-buffer eshell-prev-buffer
                    default-directory))))
    (eshell/cd dir)))

;; eshell 起動して git プロジェクトのトップディレクトリへ移動
(defun eshell/cdp ()
  (let* ((cmd "git rev-parse --show-toplevel")
         (dir (with-temp-buffer
                (unless (call-process-shell-command cmd nil t)
                  (error "Here is not Git Repository"))
                (goto-char (point-min))
                (buffer-substring-no-properties
                 (point) (line-end-position)))))
    (eshell/cd dir)))


;; git branch を取得する → git 関連の補完で利用
(defun my/git-branches ()
  (split-string (shell-command-to-string "git branch | sed -e 's/[ *]*//'")))


;; pcomplete ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun pcomplete/m ()
  "Completion for `m' (`git merge')"
  (pcomplete-here* (my/git-branches)))

(defun pcomplete/co ()
  "Completion for `co' (`git checkout')"
  (pcomplete-here* (my/git-branches)))

(defun pcomplete/bd ()
  "Completion for `bd' (`git branch -d')"
  (pcomplete-here* (my/git-branches)))

(defun pcomplete/a ()
  "Completion for `a' (`git add -p')"
  (while (pcomplete-here (my/git-modified-files))))

(defun my/git-untracked-files ()
  (split-string (shell-command-to-string "git status -s -u | sed -e 's/^...//'")))

(defconst pcmpl-git-commands
  '("add" "bisect" "branch" "checkout" "clone"
    "commit" "diff" "fetch" "grep"
    "init" "log" "merge" "mv" "pull" "push" "rebase"
    "reset" "rm" "show" "status" "tag" )
  "List of `git' commands")

(defun pcomplete/git ()
  "Completion for `git'"
  ;; Completion for the command argument.
  (pcomplete-here* pcmpl-git-commands)
  ;; complete files/dirs forever if the command is `add' or `rm'
  (cond
   ((pcomplete-match (regexp-opt '("add") ))
    (while (pcomplete-here (my/git-untracked-files))))
   ((pcomplete-match (regexp-opt '("rm" "reset" "mv")) 1)
    (while (pcomplete-here (pcomplete-entries))))))

(defun my/git-unstaged-files ()
  "Return a list of files which are modified but unstaged."
  (split-string (shell-command-to-string "git status -s | egrep '^.M' | sed -e 's/^.M //'")))

(defun pcomplete/d ()
  "Completion for `d' (`git diff')."
  (while (pcomplete-here (my/git-unstaged-files))))

(defun my/git-staged-files ()
  "Return a list of staged files."
  (split-string (shell-command-to-string "git status -s | egrep '^M' | sed -e 's/^M.//'")))

(defun pcomplete/dc ()
  "Completion for `dc' (`git diff')."
  (while (pcomplete-here (my/git-staged-files))))
