
;;====================
;; tabbar.el
;;====================
;; (require 'tabbar)
;; (require 'cl)
;; ;; タブに表示しないものの設定
;; ;; (setq my-tabbar-x-list (list "*Compile-Log*" "*anything*" "*anything complete*" "*howm-keys:*"))
;; ;; (defun my-tabbar-buffer-list ()
;; ;;   (remove-if
;; ;;     (lambda (buffer) (member (buffer-name buffer) my-tabbar-x-list))
;; ;;     (tabbar-buffer-list)))
;; ;; (setq tabbar-buffer-list-function 'my-tabbar-buffer-list)
;; (defvar my-tabbar-displayed-buffers
;;   '("*Backtrace*" "*Colors*" "*Faces*" "*vc-")
;;   "*Regexps matches buffer names always included tabs.")

;; (defun my-tabbar-buffer-list ()
;;   "Return the list of buffers to show in tabs.
;; Exclude buffers whose name starts with a space or an asterisk.
;; The current buffer and buffers matches `my-tabbar-displayed-buffers'
;; are always included."
;;   (let* ((hides (list ?\  ?\*))
;;          (re (regexp-opt my-tabbar-displayed-buffers))
;;          (cur-buf (current-buffer))
;;          (tabs (delq nil
;;                      (mapcar (lambda (buf)
;;                                (let ((name (buffer-name buf)))
;;                                  (when (or (string-match re name)
;;                                            (not (memq (aref name 0) hides)))
;;                                    buf)))
;;                              (buffer-list)))))
;;     ;; Always include the current buffer.
;;     (if (memq cur-buf tabs)
;;         tabs
;;       (cons cur-buf tabs))))
;; (setq tabbar-buffer-list-function 'my-tabbar-buffer-list)

;; ;; 常に有効化
;; (tabbar-mode)

;; ;; グループ化を使わない
;; (setq tabbar-buffer-groups-function nil)

;; ;; 左に表示されるボタンを無効化
;; (dolist (btn '(tabbar-buffer-home-button
;;                tabbar-scroll-left-button
;;                tabbar-scroll-right-button))
;;   (set btn (cons (cons "" nil)
;;                  (cons "" nil))))

;; ;; 色設定
;; ;; タブバー背景
;; (set-face-attribute
;;  'tabbar-default nil
;;  :background "gray5"
;;  :height 1.0)
;; ;; 非アクティブタブ
;; (set-face-attribute
;;  'tabbar-unselected nil
;;  :background "gray15"
;;  :foreground "white"
;;  :box nil
;;  :height 0.9)
;; ;;アクティブタブ
;; (set-face-attribute
;;  'tabbar-selected nil
;;  :background "black"
;;  :foreground "#e7c547" ; yellow
;;  ;; :foreground "#d54e53" ; red
;;  ;; :foreground "#e78c45" ; orange
;;  ;; :foreground "#7aa6da" ; blue
;;  ;; :box nil
;;  :box '(:line-width 1 :color "#7aa6da") ; blue
;;  :height 0.9)

;; ;; 幅設定
;; (setq tabbar-separator '(0.6))

;; ;; 表示切り替え
;; (global-set-key [(control tab)]       'tabbar-forward-tab)
;; (global-set-key [(control shift tab)] 'tabbar-backward-tab)


