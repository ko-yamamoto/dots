;;====================
;; install-lisp
;;====================
(require 'install-elisp)
;; インストール場所
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")


;;====================
;; auto-install
;;====================
;; (require 'auto-install)
;; (setq auto-install-directory "~/.emacs.d/elisp/")
;; (auto-install-update-emacswiki-package-name t)
;; (auto-install-compatibility-setup)


(when is_emacs24

  ;;====================
  ;; package.el
  ;;====================
  (require 'package)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("tromey" . "http://tromey.com/elpa/"))

  ;; インストールする場所
  (setq package-user-dir (concat user-emacs-directory "elpa"))

  ;;インストールしたパッケージにロードパスを通してロードする
  (package-initialize)


)
