(use-package hydra
  :config
  ;; multiple-cursors
  (global-set-key
   (kbd "C-c m")
   (defhydra hydra-multiple-cursors (:hint nil)
     "
 ^multiple-cursors
 ^Up^             ^Down^           ^Miscellaneous           % 2(mc/num-cursors) cursor%s(if (> (mc/num-cursors) 1) \"s\" \"\")
------------------------------------------------------------------
 [_p_]   Next     [_n_]   Next     [_l_] Edit lines  [_i_] Insert numbers
 [_P_]   Skip     [_N_]   Skip     [_a_] Mark all    [_b_] Insert letters
 [_M-p_] Unmark   [_M-n_] Unmark   [_s_] Search
 [Click] Cursor at point       [_q_] Quit"
     ("l" mc/edit-lines :exit t)
     ("a" mc/mark-all-like-this :exit t)
     ("n" mc/mark-next-like-this)
     ("N" mc/skip-to-next-like-this)
     ("M-n" mc/unmark-next-like-this)
     ("p" mc/mark-previous-like-this)
     ("P" mc/skip-to-previous-like-this)
     ("M-p" mc/unmark-previous-like-this)
     ("s" mc/mark-all-in-region-regexp :exit t)
     ("i" mc/insert-numbers :exit t)
     ("b" mc/insert-letters :exit t)
     ("<mouse-1>" mc/add-cursor-on-click)
     ;; Help with click recognition in this hydra
     ("<down-mouse-1>" ignore)
     ("<drag-mouse-1>" ignore)
     ("q" nil)))

  ;; start C-q
  (global-set-key
   (kbd "C-q")
   (defhydra hydra-c-q (:hint nil)
     "
 ^tab-bar^        ^histryf^      ^window^                      ^window-move^   ^buffer^          ^buf-move^     ^moccur^                    ^ag git^
---------------------------------------------------------------------------------------------------------------------------------------------------------------
 [_c_] Create     [_[_] Back     [_C-r_] Resize                [_l_] Right     [_n_] Next        [_L_] Right    [_o_] swiper                [_g g_] counsel-ag
 [_n_] Next       [_]_] Next     [_v_] Split ー                [_h_] Left      [_p_] Previous    [_H_] Left     [_m g_] moccur-grep-find    [_g s_] magit-status
 [_p_] Previous   ^   ^          [_s_] Split |                 [_j_] Down      ^   ^             [_J_] Down     [_m o_] occur-by-moccur     ^     ^
 [_k_] Kill       [_0_] Delete window           [_k_] Up        ^   ^             [_K_] Up       ^   ^                       ^     ^
 [_x_] Kill       ^   ^          [_1_] Delete other windows    ^   ^           ^   ^             ^   ^          ^   ^                       ^     ^
 ^   ^            ^   ^          [_SPC_] Toggle window
"
     ;; elscreen
     ;; ("c" elscreen-create :exit t)
     ;; ("n" elscreen-next)
     ;; ("p" elscreen-previous)
     ;; ("a" elscreen-toggle)
     ;; ("k" elscreen-kill)
     ;; ("x" elscreen-kill)
     ;; ("C-x" elscreen-kill)
     ;; tab-bar
     ("c" tab-new :exit t)
     ("n" tab-bar-switch-to-next-tab)
     ("p" tab-bar-switch-to-prev-tab)
     ("k" tab-close)
     ("x" tab-close)
     ;; historyf
     ("[" historyf-back)
     ("]" historyf-forward)
     ;; window
     ("C-r" my-window-resizer :exit t)
     ("v" split-window-vertically)
     ("s" split-window-horizontally)
     ("0" delete-window)
     ("1" delete-other-windows)
     ("SPC" window-split-toggle)
     ;; window move
     ("l" windmove-right)
     ("h" windmove-left)
     ("j" windmove-down)
     ("k" windmove-up)
     ;; buf-move
     ("L" buf-move-right)
     ("H" buf-move-left)
     ("J" buf-move-down)
     ("K" buf-move-up)
     ;; moccur
     ("m o" occur-by-moccur)
     ("m g" moccur-grep-find)
     ;; swiper
     ("o" swiper)
     ;; ag
     ("g g" counsel-ag)

     ;; github
     ("g s" magit-status)
     ))

  ;; git
  (global-set-key
   (kbd "C-c g")
   (defhydra hydra-git (:hint nil)
     "
 ^git-gutter^           ^Magit
------------------------------------------------------------------
 [_n_] Next Hunk        [_g_] status
 [_p_] Previous Hunk
"
     ;; git gutter
     ("n" git-gutter:next-hunk)
     ("p" git-gutter:previous-hunk)
     ;; magit
     ("g" magit-status :exit t)))

  ;; flycheck
  (global-set-key
   (kbd "C-c f")
   (defhydra hydra-flycheck (:hint nil)
     "
 ^mode^                        ^Errors^            ^Check
------------------------------------------------------------------
 [_g_] global-flycheck-mode    [_l_] List          [_._] Why
 [_f_] flycheck-mode           [_n_] Next
 ^   ^                         [_p_] Previous
 ^   ^
"
     ("f" flycheck-mode :exit t)
     ("g" global-flycheck-mode :exit t)
     ("l" flycheck-list-errors :exit t)
     ("n" flycheck-next-error)
     ("p" flycheck-previous-error)
     ("." flycheck-explain-error-at-point)
     ))

  )

