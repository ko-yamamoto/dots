;; 環境切り分け用の定義作成

(defvar is_emacs22 (equal emacs-major-version 22))
(defvar is_emacs23 (equal emacs-major-version 23))
(defvar is_emacs24 (equal emacs-major-version 24))

(defvar is_window-sys (not (eq (symbol-value 'window-system) nil)))

;; Mac全般のとき
(defvar is_mac (or (eq window-system 'mac) (featurep 'ns)))

;; Carbon Emacsのとき
(defvar is_carbon (and is_mac is_emacs22 is_window-sys))

;; Cocoa Emacsのとき
(defvar is_cocoa (and is_mac is_emacs23 is_window-sys))
(defvar is_inline-patch (eq (boundp 'mac-input-method-parameters) t))
(defvar is_darwin (eq system-type 'darwin))

;; cygwinのとき
(defvar is_cygwin (eq system-type 'cygwin))

;; gnu/linuxの時
(defvar is_linux (eq system-type 'gnu/linux))

;; winNTのとき
(defvar is_winnt  (eq system-type 'windows-nt))

;; Win全般のとき
(defvar is_win (or is_cygwin is_winnt))

;; Winでない場合
(defvar is_not_win (or is_mac is_linux))

(when is_winnt
;;   (setq cygwin-mount-cygwin-bin-directory "c:/cygwin/bin")
  (require 'cygwin-mount)
  (cygwin-mount-activate)
  )

