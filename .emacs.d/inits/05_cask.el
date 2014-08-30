;; curl -fsSkL https://raw.github.com/cask/cask/master/go | python


(when is_linux
  (require 'cask "~/.cask/cask.el")
  (cask-initialize)
)

(when is_mac
  (require 'cask "/usr/local/Cellar/cask/0.7.1/cask.el")
  (cask-initialize)
)
