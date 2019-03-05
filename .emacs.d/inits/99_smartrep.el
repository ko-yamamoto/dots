(use-package smartrep
  :disabled
  :config
  (setq smartrep-mode-line-active-bg "#C678DD")

  (smartrep-define-key
      global-map "C-q" '(("c" . 'elscreen-create)
                         ("n" . 'elscreen-next)
                         ("p" . 'elscreen-previous)
                         ("a" . 'elscreen-toggle)
                         ("k" . 'elscreen-kill)
                         ("x" . 'elscreen-kill)
                         ))
  ;; ("a" . (lambda () (beginning-of-buffer-other-window 0)))
  ;; ("e" . (lambda () (end-of-buffer-other-window 0)))))

  ;; multiple-cursors
  (global-unset-key (kbd "C-c m"))
  (smartrep-define-key global-map (kbd "C-c m")
    '(("n"        . 'mc/mark-next-like-this)
      ("p"        . 'mc/mark-previous-like-this)
      ("m"        . 'mc/mark-more-like-this-extended)
      ("u"        . 'mc/unmark-next-like-this)
      ("U"        . 'mc/unmark-previous-like-this)
      ("s"        . 'mc/skip-to-next-like-this)
      ("S"        . 'mc/skip-to-previous-like-this)
      ("*"        . 'mc/mark-all-like-this)
      ("d"        . 'mc/mark-all-like-this-dwim)
      ("i"        . 'mc/insert-numbers)
      ("o"        . 'mc/sort-regions)
      ("O"        . 'mc/reverse-regions)))


  (smartrep-define-key global-map (kbd "C-q")
    '(("["        . 'historyf-back)
      ("]"        . 'historyf-forward)))

  (smartrep-define-key global-map (kbd "C-q")
    '(("l"        . 'windmove-right)
      ("h"        . 'windmove-left)
      ("j"        . 'windmove-down)
      ("k"        . 'windmove-up)))

  (smartrep-define-key global-map (kbd "C-q")
    '(("L"        . 'buf-move-right)
      ("H"        . 'buf-move-left)
      ("J"        . 'buf-move-down)
      ("K"        . 'buf-move-up)))

  (smartrep-define-key global-map (kbd "C-x")
    '(("n"        . 'next-buffer)
      ("p"        . 'previous-buffer)))

  (smartrep-define-key global-map (kbd "C-c g")
    '(("n"        . 'git-gutter:next-hunk)
      ("p"        . 'git-gutter:previous-hunk)))

  )
