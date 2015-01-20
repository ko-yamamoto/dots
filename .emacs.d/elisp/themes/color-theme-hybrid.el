;;; Author: Ethan Schoonover, Solarized; Greg Pfeil, Emacs adaptation
;;; URL: http://ethanschoonover.com/solarized

;;; This file is not (YET) part of GNU Emacs.

;;; # Usage

;;; 1. Install the color-theme package
;;;   (http://www.emacswiki.org/cgi-bin/wiki/ColorTheme)
;;; 2. Load this file
;;; 3. M-x color-theme-solarized-[dark|light]

(eval-when-compile
  (require 'color-theme))

(defun color-theme-hybrid ()
  "Hybrid Terminal Colours. Uses the palette from Tomorrow-Night:
https://github.com/chriskempson/tomorrow-theme/blob/master/vim/colors/Tomorrow-Night.vim
vim: ft=xdefaults"
  (interactive t)
  (let (
        ;; (background  "#1d1f21")
        (background  "#2E3436")
        (foreground  "#c5c8c6")
        (selection   "#373b41")
        (line        "#282a2e")
        (comment     "#707880")
        (red         "#cc6666")
        (orange      "#de935f")
        ;; (yellow      "#f0c674")
        (yellow      "#ffe174")
        (green       "#b5bd68")
        (lgreen      "#e1e7cb")
        (aqua        "#8abeb7")
        (blue        "#81a2be")
        (purple      "#b294bb")
        (magenta     "#85678F")
        (violet      "#6c71c4")
        (cyan        "#5E8D87")
        (window      "#303030")
        (darkcolumn  "#1c1c1c")
        (addbg       "#5F875F")
        (addfg       "#d7ffaf")
        (changebg    "#5F5F87")
        (changefg    "#d7d7ff")
        (darkblue    "#00005f")
        (darkcyan    "#005f5f")
        (darkred     "#5f0000")
        (darkgreen   "#005f00")
        (darkpurple  "#5f005f")
        (white       "#ffffff")
        (black       "#000000")
        )

    (color-theme-install
     `(color-theme-hybrid
       ((foreground-color . ,foreground)
        (background-color . ,background)
        (cursor-color . ,blue))
       (default ((t (:foreground ,foreground))))
       (escape-glyph-face ((t (:foreground ,red))))
       (fringe ((t (:foreground ,addbg :background ,background))))
       (highlight ((t (:background ,line))))
       (match ((t (:background ,background :foreground ,nil))))
       (isearch ((t (:background ,yellow :foreground ,black))))
       (isearch-lazy-highlight-face ((t (:background ,background :foreground ,nil))))
       (isearch-fail ((t (:background ,orange))))
       (menu ((t (:foreground ,foreground :background ,selection))))
       (minibuffer-prompt ((t (:foreground ,blue))))
       (mode-line
        ((t (:foreground ,comment :background ,yellow :foreground ,background
                         :box (:line-width 1 :color ,green)))))
       (mode-line-buffer-id ((t (:foreground ,comment))))
       (mode-line-inactive
        ((t (:foreground ,comment  :background ,yellow
                         :box (:line-width 1 :color ,yellow)))))
       (region ((t (:background ,selection))))
       (secondary-selection ((t (:background ,selection))))
       (trailing-whitespace ((t (:foreground ,red :inverse-video t))))
       (vertical-border ((t (:foreground ,foreground))))
       ;; compilation
       (compilation-info ((t (:forground ,green :bold t))))
       (compilation-warning ((t (:foreground ,orange :bold t))))
       ;; customize
       (custom-button
        ((t (:background ,selection :box (:line-width 2 :style released-button)))))
       (custom-button-mouse ((t (:inherit custom-button :foreground ,comment))))
       (custom-button-pressed
        ((t (:inherit custom-button-mouse
                      :box (:line-width 2 :style pressed-button)))))
       (custom-comment-tag ((t (:background ,selection))))
       (custom-comment-tag ((t (:background ,selection))))
       (custom-documentation ((t (:inherit default))))
       (custom-group-tag ((t (:foreground ,orange :bold t))))
       (custom-link ((t (:foreground ,violet))))
       (custom-state ((t (:foreground ,green))))
       (custom-variable-tag ((t (:foreground ,orange :bold t))))
       ;; emacs-wiki
       (emacs-wiki-bad-link-face ((t (:foreground ,red :underline t))))
       (emacs-wiki-link-face ((t (:foreground ,blue :underline t))))
       (emacs-wiki-verbatim-face ((t (:foreground ,addbg :underline t))))
       ;; font-lock
       (font-lock-builtin-face ((t (:foreground ,lgreen))))
       (font-lock-comment-face ((t (:foreground ,comment))))
       (font-lock-doc-face ((t (:foreground ,comment))))
       (font-lock-constant-face ((t (:foreground ,orange))))
       (font-lock-function-name-face ((t (:foreground ,red :bold t))))
       (font-lock-keyword-face ((t (:foreground ,yellow))))
       (font-lock-string-face ((t (:foreground ,purple))))
       (font-lock-type-face ((t (:foreground ,green))))
       (font-lock-variable-name-face ((t (:foreground ,blue))))
       (font-lock-warning-face ((t (:foreground ,red :bold t))))
       (c-annotation-face ((t (:foreground ,red))))

       ;; info
       (info-xref ((t (:foreground ,blue :underline t))))
       (info-xref-visited ((t (:inherit info-xref :foreground ,magenta))))

       ;; org
       (org-hide ((t (:foreground ,background))))
       (org-todo ((t (:foreground ,red :bold t))))
       (org-done ((t (:foreground ,green :bold t))))
       (org-date ((t (:foreground ,comment :bold t))))
       (org-level-1 ((t (:foreground ,red))))
       (org-level-2 ((t (:foreground ,blue))))
       (org-level-3 ((t (:foreground ,green))))
       (org-level-4 ((t (:foreground ,yellow))))
       (org-level-5 ((t (:foreground ,purple))))
       (org-link ((t (:foreground ,blue))))

       ;; show-paren
       (show-paren-match-face ((t (:background ,orange :foreground ,white :bold t))))
       (show-paren-mismatch-face ((t (:background ,red :foreground ,white :bold t))))

       ;; helm
       (helm-header ((t (:background ,green :foreground ,darkgreen))))
       (header-line ((t (:background ,green :foreground ,darkgreen))))
       (helm-source-header ((t (:background ,green :foreground ,darkgreen))))
       (helm-selection ((t (:background ,selection))))
       (helm-visible-mark ((t (:background ,red :foreground ,foreground))))
       (helm-ff-directory ((t (:background ,nil :foreground ,blue))))
       (helm-candidate-number ((t (:background ,nil :foreground ,orange))))
       (helm-ff-prefix ((t (:background ,red :foreground ,white :bold t))))
       (helm-ff-symlink ((t (:foreground ,comment))))
       (helm-buffer-size ((t (:foreground ,comment))))
       (helm-buffer-process ((t (:foreground ,comment))))

       ;; elscreen
       (elscreen-tab-background-face ((t (:background ,background))))
       (elscreen-tab-control-face ((t (:background ,background :foreground ,foreground))))
       (elscreen-tab-current-screen-face ((t (:background ,background :foreground ,yellow))))
       (elscreen-tab-other-screen-face ((t (:background ,background :foreground ,comment))))

       ;; yalinum
       (yalinum-face ((t (:background ,background :foreground ,comment))))
       ;; (yalinum-bar-face ((t (:background "#b5bd68" :foreground ,base3))))
       (yalinum-bar-face ((t (:background ,blue :foreground ,background))))

       ;; speebar
       (speedbar-tag-face ((t (:background ,background :foreground ,foreground))))
       (speedbar-selected-face ((t (:background ,background :foreground ,red))))
       (speedbar-file-face ((t (:background ,background :foreground ,"#888888"))))

       ;; eshell
       (eshell-prompt ((t (:foreground ,"#888888"))))
       (eshell-ls-executable ((t (:foreground ,red))))
       (eshell-ls-missing ((t (:foreground ,orange))))
       (eshell-ls-archive ((t (:foreground ,green))))
       (eshell-ls-directory ((t (:foreground ,blue))))
       (eshell-ls-readonly ((t (:foreground ,yellow))))
       (eshell-ls-symlink ((t (:foreground ,violet))))

       ;; dired
       (dired-flagged ((t (:background ,background :foreground ,orange))))

       ;; slime
       (slime-repl-inputed-output-face ((t (:foreground ,red))))

       ;; diff
       (diff-add ((t (:foreground ,green :background ,background))))
       (diff-removed ((t (:foreground ,red :background ,background))))
       (diff-changed ((t (:foreground ,yellow :inverse-video t))))

       ;; magit
       (magit-diff-add ((t (:foreground ,green :background ,background))))
       (magit-diff-del ((t (:foreground ,red :background ,background))))
       (magit-diff-none ((t (:background ,background))))
       (magit-header ((t (:foreground ,green :box (:line-width 1)))))
       (magit-item-highlight ((t (:foreground nil :background ,selection))))

       ;; auto-complete
       (ac-candidate-face ((t (:background ,blue :foreground ,background))))
       (ac-selection-face ((t (:background ,yellow :foreground ,background))))

       (sh-heredoc ((t (:foreground ,yellow))))

       ;; rainbow-delimiters
       (rainbow-delimiters-depth-1-face ((t (:foreground ,orange :bold t))))
       (rainbow-delimiters-depth-2-face ((t (:foreground ,blue :bold t))))
       (rainbow-delimiters-depth-3-face ((t (:foreground ,magenta :bold t))))
       (rainbow-delimiters-depth-4-face ((t (:foreground ,cyan :bold t))))
       (rainbow-delimiters-depth-5-face ((t (:foreground ,green :bold t))))
       (rainbow-delimiters-depth-6-face ((t (:foreground ,yellow :bold t))))
       (rainbow-delimiters-depth-7-face ((t (:foreground ,violet :bold t))))
       (rainbow-delimiters-depth-8-face ((t (:foreground ,addbg :bold t))))
       (rainbow-delimiters-depth-9-face ((t (:foreground ,blue :bold t))))

       ;; highlight-indentation
       (highlight-indentation-face ((t (:background "#fcf5dd"))))

       ;; auto-highlight-symbol
       (ahs-face ((t (:background ,green :foreground ,background))))
       (ahs-definition-face ((t (:background ,yellow :foreground ,background))))
       (ahs-plugin-defalt-face ((t (:background nil :foreground nil))))

       ;; moccur
       (moccur-face ((t (:background ,background))))
       (moccur-current-line-face ((t (:background ,green))))

       ;; auto-highlight-symbol
       (ahs-face ((t (:background ,background))))
       (ahs-definition-face ((t (:background ,yellow :foreground ,black))))
       (ahs-plugin-defalt-face ((t (:background nil :foreground nil))))

       ;;emacs-anzu
       (anzu-mode-line ((t (:foreground ,blue :bold t))))

       ;; skk
       (skk-dcomp-face ((t (:foreground ,addbg))))
       (skk-show-mode-inline-face ((t (:background ,background))))

       ;; markdown
       (markdown-header-face-1 ((t (:foreground ,red :bold t))))
       (markdown-header-face-2 ((t (:foreground ,yellow :bold t))))
       (markdown-header-face-3 ((t (:foreground ,blue :bold t))))
       (markdown-header-face-4 ((t (:foreground ,lgreen :bold t))))
       (markdown-header-face-5 ((t (:foreground ,orange :bold t))))

       ;; rst
       (rst-level-1-face ((t (:foreground ,red :background ,background :bold t))))
       (rst-level-2-face ((t (:foreground ,blue :background ,background :bold t))))
       (rst-level-3-face ((t (:foreground ,lgreen :background ,background :bold t))))
       (rst-level-4-face ((t (:foreground ,orange :background ,background :bold t))))
       (rst-level-5-face ((t (:foreground ,yellow :background ,background :bold t))))

       ;; emacs-swoop

       (swoop-face-target-words ((t (:background ,yellow :foreground ,black))))
       (swoop-face-target-line ((t (:background ,selection))))
       (swoop-face-line-number ((t (:foreground ,blue))))
       (swoop-face-line-buffer-name ((t (:background ,blue))))

       ))))


(provide 'color-theme-hybrid)
