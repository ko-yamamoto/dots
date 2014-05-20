(require 'multiple-cursors)

;; ;; 複数行選択してから全ての行にカーソル追加
;; (global-set-key (kbd "C-c m m") 'mc/edit-lines)
;; ;; リージョンと一致する箇所で現在行より下にあるもの1つを追加
;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; ;; リージョンと一致する箇所で現在行より上にあるもの1つを追加
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; ;; リージョンと一致する箇所を↑↓キーで追加。←で追加せずに次の箇所へ。→で取り消し(1つ戻る)
;; (global-set-key (kbd "C-c m e") 'mc/mark-more-like-this-extended)
;; ;; リージョンと一致する箇所全て追加
;; (global-set-key (kbd "C-c m a") 'mc/mark-all-like-this)
;; ;; 良い感じに追加
;; (global-set-key (kbd "C-c m d") 'mc/mark-all-like-this-dwim)
;; ;; HTML などで対応するタグを追加
;; (global-set-key (kbd "C-c m t") 'mc/mark-sgml-tag-pair)
;; → smartrep.el で設定
