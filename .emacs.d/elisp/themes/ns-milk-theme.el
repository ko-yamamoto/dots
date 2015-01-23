;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; nishisasa-theme


(unless (>= 24 emacs-major-version)
  (error "requires Emacs 24 or later."))

(deftheme ns-milk)

(let ((*background*         "#f9f9f8")
      (*comments*           "#919398")
      (*constant*           "#8abeb7")
      (*current-line*       "#e8eaed")
      (*cursor-underscore*  "#0e1f5b")
      (*keywords*           "#cc6666")
      (*line-number*        "#EEE")
      (*method-declaration* "#b294bb")
      ;; (*mode-line-bg*       "#555")
      (*mode-line-bg*       "#f0c674")
      (*mode-inactive-bg*   "#999")
      ;; (*mode-line-fg*       "#EEE")
      (*mode-line-fg*       "#cc6666")
      (*normal*             "#191919")
      (*number*             "#5b93fc")
      (*operators*          "#a7b14d")
      (*warning*            "#3b5998")
      (*regexp*             "#ffe174")
      (*string*             "#7b7b7b")
      (*variable*           "#7498b7")
      (*visual-selection*   "#CCC")

      (red         "#cc6666")
      (orange      "#de935f")
      (yellow      "#ffe174")
      (green       "#a7b14d")
      (lgreen      "#e1e7cb")
      (aqua        "#8abeb7")
      (blue        "#7498b7")
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

  (custom-theme-set-faces
   'ns-milk

   `(bold ((t (:bold t))))
   `(button ((t (:foreground, *keywords* :underline t))))
   `(default ((t (:background, *background* :foreground, *normal*))))
   `(header-line ((t (:background, *mode-line-bg* :foreground, *normal*)))) ;; info header
   `(highlight ((t (:background, *current-line*))))
   `(highlight-face ((t (:background, *current-line*))))
   ;; `(hl-line ((t (:background, *current-line* :underline t))))
   `(hl-line ((t (:background, *current-line*))))
   `(info-xref ((t (:foreground, *keywords* :underline t))))
   `(region ((t (:background, *visual-selection*))))
   `(underline ((nil (:underline t))))

   ;; font-lock
   `(font-lock-builtin-face ((t (:foreground, *operators*))))
   `(font-lock-comment-delimiter-face ((t (:foreground, *comments*))))
   `(font-lock-comment-face ((t (:foreground, *comments*))))
   `(font-lock-constant-face ((t (:foreground, *constant*))))
   `(font-lock-doc-face ((t (:foreground, *comments*))))
   `(font-lock-doc-string-face ((t (:foreground, *string*))))
   `(font-lock-function-name-face ((t (:foreground, *method-declaration*))))
   `(font-lock-keyword-face ((t (:foreground, *keywords* :bold t))))
   `(font-lock-negation-char-face ((t (:foreground, *warning*))))
   `(font-lock-number-face ((t (:foreground, *number*))))
   `(font-lock-preprocessor-face ((t (:foreground, *keywords*))))
   `(font-lock-reference-face ((t (:foreground, *constant*))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground, *regexp*))))
   `(font-lock-regexp-grouping-construct ((t (:foreground, *regexp*))))
   `(font-lock-string-face ((t (:foreground, *string*))))
   `(font-lock-type-face ((t (:foreground, *operators*))))
   `(font-lock-variable-name-face ((t (:foreground, *variable* :bold t))))
   `(font-lock-warning-face ((t (:foreground, *warning*))))

   ;; GUI
   `(fringe ((t (:background, *background*))))
   `(linum ((t (:background, *line-number*))))
   `(minibuffer-prompt ((t (:foreground, *variable*))))
   `(mode-line ((t (:background, *mode-line-bg* :foreground, *mode-line-fg*))))
   `(mode-line-inactive ((t (:background, *mode-inactive-bg* :foreground, *background*))))
   `(cursor ((t (:background, *cursor-underscore*))))
   `(text-cursor ((t (:background, *cursor-underscore*))))
   `(vertical-border ((t (:foreground, *visual-selection*)))) ;; between splits

   ;; show-paren
   `(show-paren-mismatch ((t (:background, *warning* :foreground, *normal* :weight bold))))
   `(show-paren-match ((t (:background, *keywords* :foreground, *normal* :weight bold))))

   ;; search
   `(isearch ((t (:background, *regexp* :foreground, *visual-selection*))))
   `(isearch-fail ((t (:background, *warning*))))
   `(lazy-highlight ((t (:background, *operators* :foreground, *visual-selection*))))

   ;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face ((t (:foreground ,orange :bold t))))
   `(rainbow-delimiters-depth-2-face ((t (:foreground ,blue :bold t))))
   `(rainbow-delimiters-depth-3-face ((t (:foreground ,magenta :bold t))))
   `(rainbow-delimiters-depth-4-face ((t (:foreground ,cyan :bold t))))
   `(rainbow-delimiters-depth-5-face ((t (:foreground ,green :bold t))))
   ;; `(rainbow-delimiters-depth-6-face ((t (:foreground ,yellow :bold t))))
   `(rainbow-delimiters-depth-6-face ((t (:foreground ,violet :bold t))))
   `(rainbow-delimiters-depth-7-face ((t (:foreground ,addbg :bold t))))
   `(rainbow-delimiters-depth-8-face ((t (:foreground ,blue :bold t))))

   ;; highlight-indentation
   `(highlight-indentation-face ((t (:background "#fcf5dd"))))

   ;; auto-highlight-symbol
   `(ahs-face ((t (:background ,green :foreground ,*background*))))
   `(ahs-definition-face ((t (:background ,yellow :foreground ,*normal*))))
   `(ahs-plugin-defalt-face ((t (:background nil :foreground nil))))

   ;; moccur
   `(moccur-face ((t (:background ,*background*))))
   `(moccur-current-line-face ((t (:background ,green))))

   ;;emacs-anzu
   `(anzu-mode-line ((t (:foreground ,blue :bold t))))

   ;; skk
   `(skk-dcomp-face ((t (:foreground ,addbg))))
   `(skk-show-mode-inline-face ((t (:background ,*background*))))

   ;; org
   `(org-hide ((t (:foreground ,*background*))))
   `(org-todo ((t (:foreground ,red :bold t))))
   `(org-done ((t (:foreground ,green :bold t))))
   `(org-date ((t (:foreground ,*comments* :bold t))))
   `(org-level-1 ((t (:foreground ,*normal* :bold t))))
   `(org-level-2 ((t (:foreground ,red :bold t))))
   `(org-level-3 ((t (:foreground ,blue :bold t))))
   `(org-level-4 ((t (:foreground ,green :bold t))))
   `(org-level-5 ((t (:foreground ,purple :bold t))))
   `(org-link ((t (:foreground ,blue :bold t))))

   ;; show-paren
   `(show-paren-match-face ((t (:background ,orange :foreground ,white :bold t))))
   `(show-paren-mismatch-face ((t (:background ,red :foreground ,white :bold t))))

   ;; helm
   `(helm-header ((t (:background ,*mode-line-bg* :foreground ,*mode-line-fg*))))
   `(header-line ((t (:background ,*mode-line-bg* :foreground ,*mode-line-fg*))))
   `(helm-source-header ((t (:background ,*mode-line-bg* :foreground ,*mode-line-fg*))))
   `(helm-selection ((t (:background ,*current-line* :bold t))))
   `(helm-visible-mark ((t (:background ,red :foreground ,*normal*))))
   `(helm-ff-directory ((t (:background ,nil :foreground ,blue))))
   `(helm-candidate-number ((t (:background ,nil :foreground ,orange))))
   `(helm-ff-prefix ((t (:background ,red :foreground ,white :bold t))))
   `(helm-ff-symlink ((t (:foreground ,*comments*))))
   `(helm-buffer-size ((t (:foreground ,*comments*))))
   `(helm-buffer-process ((t (:foreground ,*comments*))))
   `(helm-match ((t (:background ,*regexp*))))

   ;; elscreen
   `(elscreen-tab-background-face ((t (:background ,*background*))))
   `(elscreen-tab-control-face ((t (:background ,*background* :foreground ,*normal*))))
   `(elscreen-tab-current-screen-face ((t (:background ,*background* :foreground ,*keywords*))))
   `(elscreen-tab-other-screen-face ((t (:background ,*background* :foreground ,*comments*))))

   ;; yalinum
   `(yalinum-face ((t (:background ,*background* :foreground ,*comments*))))
   `(yalinum-bar-face ((t (:background ,*mode-line-bg* :foreground ,*background*))))

   ;; speebar
   `(speedbar-tag-face ((t (:background ,*background* :foreground ,*normal*))))
   `(speedbar-selected-face ((t (:background ,*background* :foreground ,red))))
   `(speedbar-file-face ((t (:background ,*background* :foreground ,"#888888"))))

   ;; eshell
   `(eshell-prompt ((t (:foreground ,"#888888"))))
   `(eshell-ls-executable ((t (:foreground ,red))))
   `(eshell-ls-missing ((t (:foreground ,orange))))
   `(eshell-ls-archive ((t (:foreground ,green))))
   `(eshell-ls-directory ((t (:foreground ,blue))))
   `(eshell-ls-readonly ((t (:foreground ,yellow))))
   `(eshell-ls-symlink ((t (:foreground ,violet))))

   ;; dired
   `(dired-flagged ((t (:background ,*background* :foreground ,orange))))
   `(dired-directory ((t (:background ,*background* :foreground ,*variable*))))

   ;; slime
   `(slime-repl-inputed-output-face ((t (:foreground ,red))))

   ;; diff
   `(diff-add ((t (:foreground ,green :background ,*background*))))
   `(diff-removed ((t (:foreground ,red :background ,*background*))))
   `(diff-changed ((t (:foreground ,yellow :inverse-video t))))

   ;; magit
   `(magit-diff-add ((t (:foreground ,green :background ,*background*))))
   `(magit-diff-del ((t (:foreground ,red :background ,*background*))))
   `(magit-diff-none ((t (:background ,*background*))))
   `(magit-header ((t (:foreground ,green :box (:line-width 1)))))
   `(magit-item-highlight ((t (:foreground nil :background ,*visual-selection*))))

   ;; auto-complete
   `(ac-candidate-face ((t (:background ,blue :foreground ,*background*))))
   `(ac-selection-face ((t (:background ,blue :foreground ,*normal* :bold t))))

   `(sh-heredoc ((t (:foreground ,yellow))))


   `(py-builtins-face ((t (:foreground ,green))))

   `(web-mode-html-tag-face ((t (:foreground ,*method-declaration*))))
   `(web-mode-html-attr-name-face ((t (:foreground ,*operators*))))

   `(mozc-cand-overlay-focused-face ((t (:foreground ,*normal* :background ,lgreen))))
   `(mozc-cand-overlay-odd-face ((t (:foreground ,*normal* :background ,*current-line*))))
   `(mozc-cand-overlay-even-face ((t (:foreground ,*normal* :background ,*current-line*))))
   `(mozc-cand-overlay-footer-face ((t (:foreground ,*normal* :background ,yellow))))
   `(mozc-preedit-selected-face ((t (:foreground ,*normal* :background ,yellow))))


   `(ido-subdir ((t (:foreground ,blue))))
   `(ido-first-match ((t (:foreground ,red :bold t))))


   ))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'ns-milk)
