(let ((mode-hooks
       '(emacs-lisp-mode-hook
         org-mode-hook
         rst-mode-hook
         java-mode-hook
         lisp-mode-hook
         clojure-mode-hook
         scala-mode-hook
         haskell-mode-hook
         sh-mode-hook
         go-mode-hook
         python-mode-hook
         ruby-mode-hook)))
  (mapcar (lambda (mode-hook) (add-hook mode-hook (lambda () (smart-newline-mode t)))) mode-hooks))
