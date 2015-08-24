;;; -*- lexical-binding: t -*-
(use-package helm
  ;; :disabled t
  :defer t
  :ensure t
  :bind (("C-;" . helm-my)
         ("M-y" . helm-show-kill-ring)
         ("M-i" . helm-imenu-anywhere)
         ("M-x" . helm-M-x)
         ("C-x C-b" . helm-buffers-list)
         ("C-q ;" . helm-git-project))
  :config
  (require 'helm-config)
  (helm-mode 1)

  (setq helm-split-window-in-side-p t)

  ;; あいまい有効化
  (setq helm-M-x-fuzzy-match t)
  (setq helm-recentf-fuzzy-match t)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-imenu-fuzzy-match t)

  ;; helm バッファは保存しないように
  (add-to-list 'desktop-modes-not-to-save 'helm-mode)

  ;; find-file では邪魔なので helm を使わない
  ;; (add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))

  ;; configuration helm variable
  (setq helm-idle-delay 0.1)
  (setq helm-input-idle-delay 0.1) ; 入力後に候補を更新するまでの時間
  (setq helm-candidate-number-limit 300) ; 候補数
  (setq helm-buffer-max-length 80) ; バッファ名の最大長
  (setq enable-recursive-minibuffers t)

  ;; (require 'helm-files)


  ;; 絞り込みでバッファがバッファ名の文字数順で並ぶのを回避
  (defadvice helm-buffers-sort-transformer (around ignore activate)
    (setq ad-return-value (ad-get-arg 0)))

  ;; action を buffer kill に入れ替えたものソース
  (defun helm-c-buffers-list-R-persistent-action (candidate)
    (if current-prefix-arg
        (helm-c-switch-to-buffer candidate)
      (helm-c-buffers-persistent-kill candidate)))

  ;; (defvar helm-source-buffers-list-R
  ;;   `((name . "Buffers")
  ;;     (init . (lambda ()
  ;;               ;; Issue #51 Create the list before `helm-buffer' creation.
  ;;               (setq helm-buffers-list-cache (helm-buffer-list))
  ;;               (let ((result (cl-loop for b in helm-buffers-list-cache
  ;;                                      maximize (length b) into len-buf
  ;;                                      maximize (length (with-current-buffer b
  ;;                                                         (symbol-name major-mode)))
  ;;                                      into len-mode
  ;;                                      finally return (cons len-buf len-mode))))
  ;;                 (unless helm-buffer-max-length
  ;;                   (setq helm-buffer-max-length (car result)))
  ;;                 (unless helm-buffer-max-len-mode
  ;;                   ;; If a new buffer is longer that this value
  ;;                   ;; this value will be updated
  ;;                   (setq helm-buffer-max-len-mode (cdr result))))))
  ;;     (candidates . helm-buffers-list-cache)
  ;;     (no-matchplugin)
  ;;     (type . buffer)
  ;;     (match helm-buffer-match-major-mode)
  ;;     (persistent-action . helm-c-buffers-list-R-persistent-action)
  ;;     (keymap . ,helm-buffer-map)
  ;;     (volatile)
  ;;     (mode-line . helm-buffer-mode-line-string)
  ;;     (persistent-help
  ;;      . "Kill this buffer / C-u \\[helm-execute-persistent-action]: Show this buffer")))

  (defclass helm-source-buffers-R (helm-source-sync helm-type-buffer)
    ((init :initform (lambda ()
                       ;; Issue #51 Create the list before `helm-buffer' creation.
                       (setq helm-buffers-list-cache (helm-buffer-list))
                       (let ((result (cl-loop for b in helm-buffers-list-cache
                                              maximize (length b) into len-buf
                                              maximize (length (with-current-buffer b
                                                                 (symbol-name major-mode)))
                                              into len-mode
                                              finally return (cons len-buf len-mode))))
                         (unless helm-buffer-max-length
                           (setq helm-buffer-max-length (car result)))
                         (unless helm-buffer-max-len-mode
                           ;; If a new buffer is longer that this value
                           ;; this value will be updated
                           (setq helm-buffer-max-len-mode (cdr result))))))
     (candidates :initform helm-buffers-list-cache)
     (matchplugin :initform nil)
     (match :initform 'helm-buffers-list--match-fn)
     (persistent-action :initform 'helm-c-buffers-list-R-persistent-action)
     (keymap :initform helm-buffer-map)
     (volatile :initform t)
     (mode-line :initform helm-buffer-mode-line-string)
     (persistent-help
      :initform
      "Kill this buffer / C-u \\[helm-execute-persistent-action]: Show this buffer")))


  (defvar helm-source-buffers-list-R (helm-make-source "Buffers" 'helm-source-buffers-R))


  ;; ディレクトリだけのソース
  (defvar helm-c-recentf-directory-source
    '((name . "Recentf Directry")
      (candidates . (lambda ()
                      (loop for file in recentf-list
                            when (file-directory-p file)
                            collect file)))
      (type . file)))
  ;; ファイルだけのソース
  (defvar helm-c-recentf-file-source
    '((name . "Recentf File")
      (candidates . (lambda ()
                      (loop for file in recentf-list
                            when (not (file-directory-p file))
                            collect file)))
      (type . file)))

  ;; (defun helm-my ()
  ;;   (interactive)
  ;;   (helm-other-buffer '(
  ;;                        ;; helm-c-source-elscreen
  ;;                        helm-source-buffers-list-R
  ;;                        ;; helm-source-buffers-list
  ;;                        ;; helm-c-source-buffers-list
  ;;                        ;; helm-c-recentf-file-source
  ;;                        helm-source-recentf
  ;;                        helm-c-recentf-directory-source
  ;;                        helm-c-source-buffer-not-found)
  ;;                      "*helm my*"))

  (defcustom helm-my-default-sources '(helm-source-buffers-list
                                       helm-c-recentf-file-source
                                       helm-c-recentf-directory-source
                                       helm-source-buffer-not-found)
    "Default sources list used in `helm-my'."
    :group 'helm-misc
    :type '(repeat (choice symbol)))

  (defun helm-my ()
    "Preconfigured `helm' lightweight version \(buffer -> recentf\)."
    (interactive)
    (require 'helm-files)
    (unless helm-source-buffers-list
      (setq helm-source-buffers-list
            (helm-make-source "Buffers" 'helm-source-buffers)))
    (let ((helm-ff-transformer-show-only-basename nil))
      (helm :sources helm-my-default-sources
            :buffer "*helm my*"
            :truncate-lines t)))

  ;; git 管理ファイルを状態に応じて表示
  (defun helm-c-sources-git-project-for (pwd)
    (loop for elt in
          '(("Modified files" . "--modified")
            ("Untracked files" . "--others --exclude-standard")
            ("All controlled files in this project" . nil))
          for title  = (format "%s (%s)" (car elt) pwd)
          for option = (cdr elt)
          for cmd    = (format "git ls-files %s" (or option ""))
          collect
          `((name . ,title)
            (init . (lambda ()
                      (unless (and (not ,option) (helm-candidate-buffer))
                        (with-current-buffer (helm-candidate-buffer 'global)
                          (call-process-shell-command ,cmd nil t nil)))))
            (candidates-in-buffer)
            (type . file))))
  (defun helm-git-project-topdir ()
    (file-name-as-directory
     (replace-regexp-in-string
      "\n" ""
      (shell-command-to-string "git rev-parse --show-toplevel"))))
  (defun helm-git-project ()
    (interactive)
    (let ((topdir (helm-git-project-topdir)))
      (unless (file-directory-p topdir)
        (error "I'm not in Git Repository!!"))
      (let* ((default-directory topdir)
             (sources (helm-c-sources-git-project-for default-directory)))
        (helm-other-buffer sources "*helm git project*"))))

  (use-package helm-descbinds
    :ensure t
    :bind (("C-^ b" . helm-descbinds))
    :config (helm-descbinds-install))


  (bind-keys :map helm-find-files-map
             ("TAB" . helm-execute-persistent-action)
             ("C-w" . kill-region-or-backward-word))

  (bind-keys :map helm-read-file-map
             ("TAB" . helm-execute-persistent-action)
             ("C-w" . kill-region-or-backward-word))

  )
