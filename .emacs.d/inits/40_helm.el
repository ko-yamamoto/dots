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

  ;; ファイルだけのソース
  (defvar helm-c-recentf-file-source
    '((name . "Recentf Files")
      (candidates . (lambda ()
                      (loop for file in recentf-list
                            when (not (file-directory-p file))
                            collect file)))
      (action
       ("Find file" . helm-find-many-files)
       ("Find file as root" . helm-find-file-as-root)
       ("Find file other window" . helm-find-files-other-window)
       ("Find file other frame" . find-file-other-frame)
       ("Open dired in file's directory" . helm-open-dired)
       ("Grep File(s) `C-u recurse'" . helm-find-files-grep)
       ("Zgrep File(s) `C-u Recurse'" . helm-ff-zgrep)
       ("Pdfgrep File(s)" . helm-ff-pdfgrep)
       ("Insert as org link" . helm-files-insert-as-org-link)
       ("Checksum File" . helm-ff-checksum)
       ("Ediff File" . helm-find-files-ediff-files)
       ("Ediff Merge File" . helm-find-files-ediff-merge-files)
       ("Etags `M-., C-u reload tag file'" . helm-ff-etags-select)
       ("View file" . view-file)
       ("Insert file" . insert-file)
       ("Add marked files to file-cache" . helm-ff-cache-add-file)
       ("Delete file(s)" . helm-delete-marked-files)
       ("Copy file(s) `M-C, C-u to follow'" . helm-find-files-copy)
       ("Rename file(s) `M-R, C-u to follow'" . helm-find-files-rename)
       ("Symlink files(s) `M-S, C-u to follow'" . helm-find-files-symlink)
       ("Relsymlink file(s) `C-u to follow'" . helm-find-files-relsymlink)
       ("Hardlink file(s) `M-H, C-u to follow'" . helm-find-files-hardlink)
       ("Open file externally (C-u to choose)" . helm-open-file-externally)
       ("Open file with default tool" . helm-open-file-with-default-tool)
       ("Find file in hex dump" . hexl-find-file)
       ("Delete file(s) from recentf" lambda
        (_candidate)
        (cl-loop for file in
                 (helm-marked-candidates)
                 do
                 (setq recentf-list
                       (delq file recentf-list)))))
      (migemo)))

  ;; ディレクトリだけのソース
  (defvar helm-c-recentf-directory-source
    '((name . "Recentf Directories")
      (init lambda nil
            (require 'recentf)
            (when helm-turn-on-recentf
              (recentf-mode 1)))
      (candidates . (lambda ()
                      (loop for file in recentf-list
                            when (file-directory-p file)
                            collect file)))
      (action
       ("Find file" . helm-find-many-files)
       ("Find file as root" . helm-find-file-as-root)
       ("Find file other window" . helm-find-files-other-window)
       ("Find file other frame" . find-file-other-frame)
       ("Open dired in file's directory" . helm-open-dired)
       ("Grep File(s) `C-u recurse'" . helm-find-files-grep)
       ("Zgrep File(s) `C-u Recurse'" . helm-ff-zgrep)
       ("Pdfgrep File(s)" . helm-ff-pdfgrep)
       ("Insert as org link" . helm-files-insert-as-org-link)
       ("Checksum File" . helm-ff-checksum)
       ("Ediff File" . helm-find-files-ediff-files)
       ("Ediff Merge File" . helm-find-files-ediff-merge-files)
       ("Etags `M-., C-u reload tag file'" . helm-ff-etags-select)
       ("View file" . view-file)
       ("Insert file" . insert-file)
       ("Add marked files to file-cache" . helm-ff-cache-add-file)
       ("Delete file(s)" . helm-delete-marked-files)
       ("Copy file(s) `M-C, C-u to follow'" . helm-find-files-copy)
       ("Rename file(s) `M-R, C-u to follow'" . helm-find-files-rename)
       ("Symlink files(s) `M-S, C-u to follow'" . helm-find-files-symlink)
       ("Relsymlink file(s) `C-u to follow'" . helm-find-files-relsymlink)
       ("Hardlink file(s) `M-H, C-u to follow'" . helm-find-files-hardlink)
       ("Open file externally (C-u to choose)" . helm-open-file-externally)
       ("Open file with default tool" . helm-open-file-with-default-tool)
       ("Find file in hex dump" . hexl-find-file)
       ("Delete file(s) from recentf" lambda
        (_candidate)
        (cl-loop for file in
                 (helm-marked-candidates)
                 do
                 (setq recentf-list
                       (delq file recentf-list)))))
      (migemo)))

  (defcustom helm-my-default-sources '(helm-source-buffers-list
                                       helm-c-recentf-file-source
                                       helm-c-recentf-directory-source
                                       helm-source-files-in-current-dir
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
