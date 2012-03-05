;;====================
;; ElScreen
;;====================
;; EmacsでGNU screen風のインターフェイスを使う
(setq elscreen-prefix-key "\C-z")
(require 'elscreen)
(if window-system
    (define-key elscreen-map "\C-z" 'iconify-or-deiconify-frame)
  (define-key elscreen-map "\C-z" 'suspend-emacs))

;; 以下は自動でスクリーンを生成する場合の設定
(defmacro elscreen-create-automatically (ad-do-it)
  `(if (not (elscreen-one-screen-p))
       ,ad-do-it
     (elscreen-create)
     (elscreen-notify-screen-modification 'force-immediately)
     (elscreen-message "New screen is automatically created")))

(defadvice elscreen-next (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

(defadvice elscreen-previous (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

(defadvice elscreen-toggle (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

(setq elscreen-display-tab 14) ; タブの幅（６以上じゃないとダメ）
(setq elscreen-tab-display-kill-screen nil) ; タブの左端の×を非表示

(global-set-key (kbd "C-z C-c") 'elscreen-clone) ; 今のウインドウを基に作成

;; C-z C-k と C-z k を入れ替え
(global-set-key (kbd "C-z C-k") 'elscreen-kill) ; スクリーンとバッファをkill
(global-set-key (kbd "C-z k") 'elscreen-kill-screen-and-buffers) ; スクリーンとバッファをkill

(global-set-key [(C-tab)] 'elscreen-next) ; ブラウザみたいに
(global-set-key [(C-S-tab)] 'elscreen-previous) ; ブラウザみたいに　その2
(global-set-key [(C-S-iso-lefttab)] 'elscreen-previous) ; ブラウザみたいに　その2 (for linux)

;; elscreen-server
(require 'elscreen-server)

;; elscreen-dired
(require 'elscreen-dired)

;; elscreen-howm
;; (require 'elscreen-howm)

;; elscreen-dnd
(require 'elscreen-dnd)

;; elscreen-color-theme
;; (require 'elscreen-color-theme)

