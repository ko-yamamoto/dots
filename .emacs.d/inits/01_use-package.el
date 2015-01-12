(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (require 'use-package nil t)
  (message "Use-package is unavailable!")
  (defmacro use-package (&rest _args)))
