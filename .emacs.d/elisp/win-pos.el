;; win-pos.el

;; Copyright (C) 2012 by nishikawasasaki
;; Author: nishikawasasaki
;; https://github.com/nishikawasasaki/win-pos.el


;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;; What is this?
;; Save window size and position.
;; Restore the size and position when you launch Emacs.


;; Install
;; Move this file into directory in load-path.
;; And this add to init.el
;; (require 'win-pos)

;; ChangeLog
;; 0.0.1: init release

;; var ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar rwps-save-file "~/.emacs.d/.winposize")
(defvar rwps-delimiter ",")


;; func ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun rwps-save-when-kill-emacs ()
  "終了時にウインドウの位置とサイズを記憶"
  (interactive)
  ;; 保存用バッファ作成
  (get-buffer-create "*rwps*")
  (switch-to-buffer "*rwps*")
  ;; 位置とサイズをバッファに書き込み
  (with-output-to-temp-buffer "*rwps*"
    (princ (window-height)) ; ウィンドウ高さ
    (princ rwps-delimiter) ; デリミタ
    (princ (window-width)) ; ウィンドウ幅
    (princ rwps-delimiter) ; デリミタ
    (princ (cdr (nth 8 (frame-parameters (selected-frame))))) ; ウィンドウX位置
    (princ rwps-delimiter) ; デリミタ
    (princ (cdr (nth 7 (frame-parameters (selected-frame))))) ; ウィンドウY位置
    )
  ;; バッファ内容を保存
  (let ((coding-system-for-write 'utf-8))
    (write-region (point-min) (point-max) rwps-save-file))
  ;; バッファ削除
  (kill-buffer "*rwps*")
)

;; 開始時にウインドウの位置とサイズを読み込み
(defun rwps-restore-when-start-emacs ()
  (interactive)
  (get-buffer-create "*rwps*")
  (switch-to-buffer "*rwps*")

  ;; 位置とサイズの保存ファイルを読み込み
  (insert-file-contents rwps-save-file)
  ;; 保存した位置とサイズをカンマ区切りでファイルから取得
  (let ((rwps-posize-str (buffer-substring (point-max) (point-min))))
    ;; カンマでスプリットしてリストへ変換
    (let ((rwps-posize-list (split-string rwps-posize-str rwps-delimiter)))
      ;; 縦幅セット (ミニバッファ分の 1 を足す)
      (set-frame-height (selected-frame) (+ 1 (string-to-number (nth 0 rwps-posize-list))))
      ;; 横幅セット
      (set-frame-width (selected-frame) (string-to-number (nth 1 rwps-posize-list)))
      ;; 座標セット
      (set-frame-position (selected-frame)
                          (string-to-number (nth 2 rwps-posize-list))
                          (string-to-number (nth 3 rwps-posize-list)))))
  ;; バッファ削除
  (kill-buffer "*rwps*"))

;; Emacs 開始時に呼び出す
(add-hook 'emacs-startup-hook 'rwps-restore-when-start-emacs)

;; Emacs 終了時に呼び出す
(add-hook 'kill-emacs-hook 'rwps-save-when-kill-emacs)


(provide 'win-pos)
