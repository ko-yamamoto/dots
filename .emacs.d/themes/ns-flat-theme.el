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


(unless (<= 24 emacs-major-version)
  (error "requires Emacs 24 or later."))

(deftheme ns-flat)

(let* (
       (red "#E74C3C")
       (orange "#E67E22")
       (yellow "#F39C12")
       (yellowL "#F1C40F")
       (green "#27AE60")
       (aqua "#3498DB")
       (blue "#2980B9")
       (purple "#9B59B6")
       (white "#ffffff")

       (base00 "#2C3E50")
       (base01 "#393939")
       (base02 "#515151")
       (base03 "#747369")
       (base04 "#a09f93")
       (base05 "#d3d0c8")
       (base06 "#e8e6df")
       (base07 "#f2f0ec")

       (*background*         base07)
       (*comments*           base03)
       (*constant*           aqua)
       (*current-line*       base06)
       (*cursor-underscore*  blue)
       (*keywords*           yellow)
       (*line-number*        base06)
       (*method-declaration* red)
       (*mode-line-bg*       base03)
       (*mode-inactive-bg*   base05)
       (*mode-line-fg*       *background*)
       (*normal*             base00)
       (*number*             blue)
       (*operators*          green)
       (*warning*            red)
       (*regexp*             aqua)
       (*string*             base04)
       (*variable*           blue)
       (*visual-selection*   base05)



       )

  (custom-theme-set-faces
   'ns-flat

   `(bold ((t (:bold t))))
   `(button ((t (:foreground, *keywords* :underline t :bold t))))
   `(default ((t (:background, *background* :foreground, *normal*))))
   `(header-line ((t (:background, *mode-line-bg* :foreground, *normal*)))) ;; info header
   `(highlight ((t (:background, *current-line*))))
   `(highlight-face ((t (:background, *current-line*))))
   ;; `(hl-line ((t (:background, *current-line* :underline t))))
   `(hl-line ((t (:background, *current-line*))))
   `(info-xref ((t (:foreground, *keywords* :underline t :bold t))))
   `(region ((t (:background, *visual-selection*))))
   `(underline ((nil (:underline t))))

   ;; font-lock
   `(font-lock-builtin-face ((t (:foreground, *operators* :bold t))))
   `(font-lock-comment-delimiter-face ((t (:foreground, *comments*))))
   `(font-lock-comment-face ((t (:foreground, *comments*))))
   `(font-lock-constant-face ((t (:foreground, *constant* :bold t))))
   `(font-lock-doc-face ((t (:foreground, *comments*))))
   `(font-lock-doc-string-face ((t (:foreground, *string*))))
   `(font-lock-function-name-face ((t (:foreground, *method-declaration* :bold t))))
   `(font-lock-keyword-face ((t (:foreground, *keywords* :bold t))))
   `(font-lock-negation-char-face ((t (:foreground, *warning*))))
   `(font-lock-number-face ((t (:foreground, *number*))))
   `(font-lock-preprocessor-face ((t (:foreground, *keywords* :bold t))))
   `(font-lock-reference-face ((t (:foreground, *constant*))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground, *regexp*))))
   `(font-lock-regexp-grouping-construct ((t (:foreground, *regexp*))))
   `(font-lock-string-face ((t (:foreground, *string* :bold t))))
   `(font-lock-type-face ((t (:foreground, *operators* :bold t))))
   `(font-lock-variable-name-face ((t (:foreground, *variable* :bold t))))
   `(font-lock-warning-face ((t (:foreground, *warning*))))

   ;; GUI
   `(fringe ((t (:background, *background*))))
   `(linum ((t (:background, *line-number*))))
   `(minibuffer-prompt ((t (:foreground, *variable*))))
   `(mode-line ((t (:background, *mode-line-bg* :foreground, *mode-line-fg* :bold t))))
   `(mode-line-inactive ((t (:background, *mode-inactive-bg* :foreground, *background* :bold t))))
   `(cursor ((t (:background, *cursor-underscore*))))
   `(text-cursor ((t (:background, *cursor-underscore*))))
   `(vertical-border ((t (:foreground, *visual-selection*)))) ;; between splits

   ;; show-paren
   `(show-paren-mismatch ((t (:background, *warning* :foreground, *normal* :weight bold))))
   `(show-paren-match ((t (:background, yellow :foreground, base00 :weight bold))))

   ;; search
   `(isearch ((t (:background ,aqua :foreground ,white :bold t))))
   `(isearch-fail ((t (:background, *warning*))))
   `(lazy-highlight ((t (:background ,aqua :foreground ,white :bold nil))))

   ;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face ((t (:foreground ,orange :bold t))))
   `(rainbow-delimiters-depth-2-face ((t (:foreground ,blue :bold t))))
   `(rainbow-delimiters-depth-3-face ((t (:foreground ,yellow :bold t))))
   `(rainbow-delimiters-depth-4-face ((t (:foreground ,green :bold t))))
   `(rainbow-delimiters-depth-5-face ((t (:foreground ,aqua :bold t))))
   `(rainbow-delimiters-depth-6-face ((t (:foreground ,purple :bold t))))
   `(rainbow-delimiters-depth-7-face ((t (:foreground ,orange :bold t))))
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
   `(moccur-edit-face ((t (:background ,yellow :foreground ,red))))
   `(moccur-edit-done-face ((t (:foreground ,blue))))

   ;;emacs-anzu
   `(anzu-mode-line ((t (:foreground ,red :bold t))))

   ;; skk
   `(skk-dcomp-face ((t (:foreground ,red))))
   `(skk-show-mode-inline-face ((t (:background ,*background*))))
   `(skk-henkan-face-default ((t (:foreground ,yellow :background ,base06 :bold t))))
   `(skk-dcomp-multiple-face ((t (:background ,base06 :foreground ,red))))
   `(skk-dcomp-multiple-trailing-face ((t (:background ,*background* :foreground ,blue))))
   `(skk-dcomp-multiple-selected-face ((t (:foreground ,yellow))))
   `(skk-emacs-hiragana-face ((t (:background ,red))))

   ;; org
   `(org-hide ((t (:foreground ,*background*))))
   `(org-todo ((t (:foreground ,red :bold t))))
   `(org-done ((t (:foreground ,green :bold t))))
   `(org-date ((t (:foreground ,*comments* :bold t))))
   `(org-level-1 ((t (:foreground ,*normal* :bold t :underline t))))
   `(org-level-2 ((t (:foreground ,red :bold t))))
   `(org-level-3 ((t (:foreground ,blue :bold t))))
   `(org-level-4 ((t (:foreground ,yellow :bold t))))
   `(org-level-5 ((t (:foreground ,green :bold t))))
   `(org-level-6 ((t (:foreground ,purple :bold t))))
   `(org-level-7 ((t (:foreground ,*normal* :bold t))))
   `(org-level-8 ((t (:foreground ,*normal* :bold t))))
   `(org-link ((t (:foreground ,blue :bold t))))
   `(org-agenda-structure ((t (:foreground ,blue))))
   `(org-agenda-date ((t (:foreground ,*normal*))))
   `(org-agenda-date-today ((t (:foreground ,blue :bold t))))
   `(org-agenda-date-weekend ((t (:foreground ,*normal*))))
   `(org-upcoming-deadline ((t (:foreground ,red :bold t))))
   `(org-time-grid ((t (:foreground ,aqua))))


   ;; markdown
   `(markdown-header-face-1 ((t (:foreground ,*normal* :bold t))))
   `(markdown-header-face-2 ((t (:foreground ,red :bold t))))
   `(markdown-header-face-3 ((t (:foreground ,blue :bold t))))
   `(markdown-header-face-4 ((t (:foreground ,green :bold t))))
   `(markdown-header-face-5 ((t (:foreground ,purple :bold t))))


   ;; show-paren
   `(show-paren-match-face ((t (:background ,orange :bold t))))
   `(show-paren-mismatch-face ((t (:background ,red :bold t))))

   ;; helm
   `(helm-header ((t (:background ,*mode-line-bg* :foreground ,*mode-line-fg*))))
   `(header-line ((t (:background ,*mode-line-bg* :foreground ,*mode-line-fg*))))
   `(helm-source-header ((t (:background ,*mode-line-bg* :foreground ,*mode-line-fg*))))
   `(helm-selection ((t (:background ,*current-line*))))
   `(helm-visible-mark ((t (:background ,red :foreground ,*normal*))))
   `(helm-ff-directory ((t (:background ,nil :foreground ,blue))))
   `(helm-buffer-directory ((t (:background ,nil :foreground ,blue))))
   `(helm-candidate-number ((t (:background ,nil :foreground ,red))))
   `(helm-ff-prefix ((t (:background ,red :bold t))))
   `(helm-ff-symlink ((t (:foreground ,*comments*))))
   `(helm-ff-file ((t (:background ,*background* :foreground ,*normal*))))
   `(helm-buffer-size ((t (:foreground ,*comments*))))
   `(helm-buffer-process ((t (:foreground ,yellow))))
   `(helm-buffer-file ((t (:foreground ,*normal*))))
   `(helm-match ((t (:background nil :foreground ,red))))
   `(helm-buffer-saved-out ((t (:foreground ,yellow :bold t))))
   `(helm-buffer-not-saved ((t (:foreground ,red :bold t))))
   `(helm-visible-mark ((t (:background ,green :bold t))))

   ;; elscreen
   `(elscreen-tab-background-face ((t (:background ,*background*))))
   `(elscreen-tab-control-face ((t (:background ,*background* :foreground ,*normal*))))
   `(elscreen-tab-current-screen-face ((t (:background ,*background* :foreground ,*keywords* :bold t))))
   `(elscreen-tab-other-screen-face ((t (:background ,*background* :foreground ,*comments* :bold t))))

   ;; yalinum
   `(yalinum-face ((t (:background ,*background* :foreground ,*comments*))))
   `(yalinum-bar-face ((t (:background ,base04 :foreground ,base01))))

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
   `(eshell-ls-symlink ((t (:foreground ,purple))))

   ;; dired
   `(dired-flagged ((t (:background ,*background* :foreground ,orange))))
   `(dired-directory ((t (:background ,*background* :foreground ,*variable*))))

   ;; slime
   `(slime-repl-inputed-output-face ((t (:foreground ,red))))

   ;; diff
   `(diff-add ((t (:foreground ,green :background ,*background*))))
   `(diff-removed ((t (:foreground ,red :background ,*background*))))
   `(diff-changed ((t (:foreground ,yellow :inverse-video t))))

   ;; ediff
   `(ediff-odd-diff-A ((t (:background ,base06))))
   `(ediff-odd-diff-B ((t (:background ,base06))))
   `(ediff-even-diff-A ((t (:background ,base06))))
   `(ediff-even-diff-B ((t (:background ,base06))))

   ;; magit
   `(magit-diff-add ((t (:foreground ,green :background ,*background*))))
   `(magit-diff-del ((t (:foreground ,red :background ,*background*))))
   `(magit-diff-none ((t (:background ,*background*))))
   `(magit-header ((t (:foreground ,green :box (:line-width 1)))))
   `(magit-item-highlight ((t (:foreground nil :background ,*visual-selection*))))

   ;; auto-complete
   `(ac-candidate-face ((t (:background ,base02 :foreground ,*background*))))
   ;; ac
   `(ac-selection-face ((t (:background ,base01 :foreground ,base05 :bold t))))
   `(ac-completion-face ((t (:foreground ,red :background ,*current-line*))))
   `(popup-scroll-bar-foreground-face ((t (:background ,base05))))
   `(popup-scroll-bar-background-face ((t (:background ,base06))))
   `(popup-tip-face ((t (:background ,base06))))

   ;; company
   `(company-tooltip-common ((t (:foreground ,yellow :background ,base06 :bold t))))
   `(company-tooltip ((t (:background ,base06))))
   `(company-tooltip-selection ((t (:background ,yellowL))))
   `(company-tooltip-common-selection ((t (:foreground ,red :background ,yellowL :bold t))))
   `(company-scrollbar-fg ((t (:background ,yellow))))
   `(company-scrollbar-bg ((t (:background ,base05))))
   `(company-preview-common ((t (:background ,base06 :foreground ,yellow))))


   `(sh-heredoc ((t (:foreground ,yellow))))

   `(py-builtins-face ((t (:foreground ,green))))

   `(web-mode-html-tag-face ((t (:foreground ,*method-declaration*))))
   `(web-mode-html-attr-name-face ((t (:foreground ,*operators*))))

   `(mozc-cand-overlay-focused-face ((t (:foreground ,*normal* :background ,green))))
   `(mozc-cand-overlay-odd-face ((t (:foreground ,*normal* :background ,*current-line*))))
   `(mozc-cand-overlay-even-face ((t (:foreground ,*normal* :background ,*current-line*))))
   `(mozc-cand-overlay-footer-face ((t (:foreground ,*normal* :background ,yellow))))
   `(mozc-preedit-selected-face ((t (:foreground ,*normal* :background ,yellow))))

   `(ido-subdir ((t (:foreground ,blue))))
   `(ido-first-match ((t (:foreground ,red :bold t))))

   `(swoop-face-target-line ((t (:background ,*current-line* :bold t))))
   `(swoop-face-target-words ((t (:background ,*regexp* :bold t))))
   `(swoop-face-header-format-line ((t (:background ,*mode-line-bg*))))
   `(swoop-face-line-buffer-name ((t (:background ,*mode-inactive-bg*))))
   `(swoop-face-line-number ((t (:foreground ,blue))))

   `(wgrep-face ((t (:background ,yellow :foreground ,red))))
   `(wgrep-delete-face ((t (:foreground ,red))))
   ;; `(wgrep-file-face ((t (:background ,*current-line* :bold t))))
   ;; `(wgrep-reject-face ((t (:background ,*current-line* :bold t))))
   `(wgrep-done-face ((t (:foreground ,blue))))

   `(compilation-info ((t (:foreground ,green))))

   `(vhl/default-face ((t (:background ,base06))))

   `(ag-match-face ((t (:background ,yellow))))
   `(ag-hit-face ((t (:foreground ,blue :bold t))))

   `(highlight-symbol-face ((t (:background ,base06 :bold t))))

   ;; powerline
   `(powerline-active1 ((t (:background ,base01))))
   `(powerline-active2 ((t (:background ,base02))))
   `(powerline-inactive1 ((t (:background ,base03))))
   `(powerline-inactive2 ((t (:background ,base04))))

   ))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'ns-flat)
