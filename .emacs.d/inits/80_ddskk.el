(use-package ddskk
  :disabled
  ;; :bind (("C-q s s" . skk-mode))
  :init
  (require 'ccc)
  (require 'popup)

  ;; 変換候補の関係を学習させる
  (require 'skk-study)

  ;; 辞書ファイル
  (setq skk-jisyo-code 'utf-8)
  (setq skk-large-jisyo "~/.emacs.d/skk/SKK-JISYO.L.utf8")

  ;; カーソルの色
  (setq skk-use-color-cursor t)
  (setq skk-cursor-hiragana-color "#f2777a")

  (setq skk-cursor-latin-color "#6699cc")

  (key-chord-define-global "jk" 'skk-mode) ;; SKK 手動開始

  ;; 動作
  (setq skk-egg-like-newline t)		          ; Enterで改行しない
  (setq skk-delete-implies-kakutei nil)       ; ▼モードで BS を押したときには確定しないで前候補を表示する
  (setq skk-henkan-strict-okuri-precedence t) ; 送り仮名が厳密に正しい候補を優先して表示
  (setq skk-show-annotation t)		          ; 注釈
  (setq skk-show-mode-show t)                 ; カーソル付近にモード切り替えを表示する
  (setq skk-show-mode-style 'tooltip)         ; デフォルトは 'inline
  (setq skk-auto-start-henkan t)              ; モードで見出し語を入力しているときに「を」や「。」などの文字を打鍵する と、SPC を押したかのように変換を開始

  (setq skk-show-tooltip t)                   ; 変換候補の表示方法
  (setq skk-tooltip-function                  ; tooltip に popup を使う
        #'(lambda (tooltip-str)
            (popup-tip tooltip-str)))

  (setq skk-search-katakana t)                ; カタカナ語を変換候補に加える

  ;; 動的補完
  (setq skk-dcomp-activate t)			      ; 動的補完
  (setq skk-dcomp-multiple-activate t)        ; 動的補完の複数候補表示
  (setq skk-dcomp-multiple-rows 5)	          ; 動的補完の候補表示件数
  ;; 動的補完の選択に C-n C-p を使う
  (defun my-skk-j-mode-on-after (&rest _)
    "Configure keys for dynamic completion."
    (define-key skk-j-mode-map "\C-n" 'skk-comp-wrapper)
    (define-key skk-j-mode-map "\C-p" 'skk-previous-comp-maybe))
  
  (advice-add 'skk-j-mode-on :after #'my-skk-j-mode-on-after)

  ;; isearch
  (add-hook 'isearch-mode-hook 'skk-isearch-mode-setup) ; isearch で skk のセットアップ
  (add-hook 'isearch-mode-end-hook 'skk-isearch-mode-cleanup) ; isearch で skk のクリーンアップ
  (setq skk-isearch-start-mode 'latin)						; isearch で skk の初期状態

  ;; 文章系のバッファを開いた時には自動的に英数モード(「SKK」モード)に入る
  (let ((function #'(lambda ()
                      (require 'skk)
                      (skk-latin-mode-on))))
    (dolist (hook '(find-file-hooks
                    ;; ...
                    mail-setup-hook
                    message-setup-hook
                    org-mode-hook))
      (add-hook hook function)))

  (when (or is_mac is_winnt is_wsl)
    (setq skk-server-portnum 1178)
    ;; (setq skk-server-host "localhost")
    (setq skk-server-host (getenv "WIN_IP"))
    (set-process-coding-system skkserv-process 'utf-8 'utf-8)
    )

  )


;; config -> ~/.skk
