(use-package ivy
  ;; :disabled t
  :bind (("C-;" . counsel-buffer-or-recentf)
         ("M-i" . counsel-imenu)
         ("M-x" . counsel-M-x)
         ("M-y" . counsel-yank-pop)
         ;; ("C-x C-b" . helm-buffers-list)
         ("C-x C-f" . counsel-find-file))
  :config
  (use-package counsel)

  ;; カーソル下の単語で counsel-ag する
  (defun ad:counsel-ag (f &optional initial-input initial-directory extra-ag-args ag-prompt caller)
    (apply f (or initial-input (ivy-thing-at-point))
           (unless current-prefix-arg
             (or initial-directory default-directory))
           extra-ag-args ag-prompt caller))
  (advice-add 'counsel-ag :around #'ad:counsel-ag)

  ;; directory を指定して ag やり直し．クエリは再利用する
  (defun my-counsel-ag-in-dir (_arg)
    "Search again with new root directory."
    (let ((current-prefix-arg '(4)))
      (counsel-ag ivy-text nil ""))) ;; also disable extra-ag-args
  (ivy-add-actions
   'counsel-ag
   '(("r" my-counsel-ag-in-dir "search in directory")))

  (use-package swiper
    ;; :bind (("C-s" . swiper-thing-at-point))
    :config
    ;; 行数でも検索できるようにする
    (setq swiper-include-line-number-in-search t))

  ;; アクティベート
  (ivy-mode 1)

  ;; ivy に履歴を記憶させる
  (use-package smex
    :config
    (setq smex-history-length 35)
    (setq smex-completion-method 'ivy))


  ;; 履歴の保存など
  (use-package prescient
    :config
    ;; ivy インターフェイスでコマンドを実行するたびに，キャッシュをファイル保存
    (setq prescient-aggressive-file-save t)
    ;; ファイルの保存先
    (setq prescient-save-file
          (expand-file-name "~/.emacs.d/prescient-save.el"))
    ;; アクティベート
    (prescient-persist-mode 1))
  (use-package ivy-prescient
    :config
    ;; =ivy= の face 情報を引き継ぐ（ただし，完全ではない印象）
    (setq ivy-prescient-retain-classic-highlighting t)
    ;; コマンドを追加
    (dolist (command '(counsel-world-clock ;; Merged!
                       counsel-app)) ;; add :caller
      (add-to-list 'ivy-prescient-sort-commands command))
    ;; フィルタの影響範囲を限定する．以下の3つは順番が重要．
    ;; (1) マイナーモードの有効化
    (ivy-prescient-mode 1)
    ;; (2) =counsel-M-x= をイニシャル入力対応にする
    (setf (alist-get 'counsel-M-x ivy-re-builders-alist)
          #'ivy-prescient-re-builder)
    ;; (3) デフォルトのイニシャル入力を上書きする
    (setf (alist-get t ivy-re-builders-alist) #'ivy--regex-ignore-order))


  ;; バッファにアイコンを表示する
  (use-package all-the-icons-ivy
    :config
    (dolist (command '(counsel-buffer-or-recentf
                       counsel-ibuffer))
      (add-to-list 'all-the-icons-ivy-buffer-commands command))
    (all-the-icons-ivy-setup))

  ;; 先頭一致の ^ を使わない
  (setq ivy-initial-inputs-alist
        '((org-agenda-refile . "^")
          (org-capture-refile . "^")
          ;; (counsel-M-x . "^") ;; 削除．必要に応じて他のコマンドも除外する．
          (counsel-describe-function . "^")
          (counsel-describe-variable . "^")
          (Man-completion-table . "^")
          (woman . "^")))

  ;; プロンプト内の位置と全体件数を表示する
  (setq ivy-count-format "(%d/%d) ")

  ;; 選択している候補の左端にアイコンを表示する
  (defface my-ivy-arrow-visible
    '((((class color) (background light)) :foreground "orange")
      (((class color) (background dark)) :foreground "#EE6363"))
    "Face used by Ivy for highlighting the arrow.")
  (defface my-ivy-arrow-invisible
    '((((class color) (background light)) :foreground "#FFFFFF")
      (((class color) (background dark)) :foreground "#31343F"))
    "Face used by Ivy for highlighting the invisible arrow.")
  (if window-system
      (when (require 'all-the-icons nil t)
        (defun my-ivy-format-function-arrow (cands)
          "Transform CANDS into a string for minibuffer."
          (ivy--format-function-generic
           (lambda (str)
             (concat (all-the-icons-faicon
                      "arrow-right"
                      :v-adjust -0.2 :face 'my-ivy-arrow-visible)
                     " " (ivy--add-face str 'ivy-current-match)))
           (lambda (str)
             (concat (all-the-icons-faicon
                      "arrow-right" :face 'my-ivy-arrow-invisible) " " str))
           cands
           "\n"))
        (setq ivy-format-functions-alist
              '((t . my-ivy-format-function-arrow))))
    (setq ivy-format-functions-alist '((t . ivy-format-function-arrow))))

  ;; `ivy-switch-buffer' (C-x b) のリストに recent files と bookmark を含める．
  (setq ivy-use-virtual-buffers t)

   ;; リスト先頭で `C-p' するとき，リストの最後に移動する
  (setq ivy-wrap t)

  (setq enable-recursive-minibuffers t)
  (setq ivy-height 30) ;; minibufferのサイズを拡大！（重要）
  (setq ivy-extra-directories nil)
  (setq ivy-re-builders-alist
        '((t . ivy--regex-plus)))

  ;; counsel設定
  (setq counsel-find-file-ignore-regexp (regexp-opt '("./" "../")))
  )
