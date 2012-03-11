;; モードライン (mode-line-format)での書式記号
;; %b -- print buffer name.
;; %f -- print visited file name.
;; %F -- print frame name.
;; %* -- print %, * or hyphen.
;; %+ -- print *, % or hyphen.
;;       %& is like %*, but ignore read-only-ness.
;;       % means buffer is read-only and * means it is modified.
;;       For a modified read-only buffer, %* gives % and %+ gives *.
;; %s -- print process status.   %l -- print the current line number.
;; %c -- print the current column number (this makes editing slower).
;;       To make the column number update correctly in all cases,`column-number-mode' must be non-nil.
;; %i -- print the size of the buffer.
;; %I -- like %i, but use k, M, G, etc., to abbreviate.
;; %p -- print percent of buffer above top of window, or Top, Bot or All.
;; %P -- print percent of buffer above bottom of window, perhaps plus Top, or print Bottom or All.
;; %n -- print Narrow if appropriate.
;; %t -- visited file is text or binary (if OS supports this distinction).
;; %z -- print mnemonics of keyboard, terminal, and buffer coding systems.
;; %Z -- like %z, but including the end-of-line format.
;; %e -- print error message about full memory.
;; %@ -- print @ or hyphen.  @ means that default-directory is on a remote machine.
;; %[ -- print one [ for each recursive editing level.  %] similar.
;; %% -- print %.
;; %- -- print infinitely many dashes.
;; モードライン
;; (setq-default mode-line-format
;;               (list "%*["
;;                     'mode-line-mule-info
;;                     "] L%l:C%c %P   %b   (%m"
;;                     'minor-mode-alist
;;                     ")"
;;                     )
;;               )

(defun arrow-right-xpm (color1 color2)
  "Return an XPM right arrow string representing."
  (format "/* XPM */
static char * arrow_right[] = {
\"12 18 2 1\",
\".	c %s\",
\" 	c %s\",
\".           \",
\"..          \",
\"...         \",
\"....        \",
\".....       \",
\"......      \",
\".......     \",
\"........    \",
\".........   \",
\".........   \",
\"........    \",
\".......     \",
\"......      \",
\".....       \",
\"....        \",
\"...         \",
\"..          \",
\".           \"};"  color1 color2))

(defun arrow-left-xpm (color1 color2)
  "Return an XPM right arrow string representing."
  (format "/* XPM */
static char * arrow_right[] = {
\"12 18 2 1\",
\".	c %s\",
\" 	c %s\",
\"           .\",
\"          ..\",
\"         ...\",
\"        ....\",
\"       .....\",
\"      ......\",
\"     .......\",
\"    ........\",
\"   .........\",
\"   .........\",
\"    ........\",
\"     .......\",
\"      ......\",
\"       .....\",
\"        ....\",
\"         ...\",
\"          ..\",
\"           .\"};"  color2 color1))


(defconst color1 "#81a2be")
(defconst color2 "#b5bd68")


(defconst comment "#969896")
(defconst red "#cc6666")
(defconst orange "#de935f")
(defconst yellow "#f0c674")
(defconst green "#b5bd68")
(defconst aqua "#8abeb7")
(defconst blue "#81a2be")
(defconst purple "#b294bb")
(defconst white "#ffffff")



(defvar arrow-right-1 (create-image (arrow-right-xpm color1 color2) 'xpm t :ascent 'center))
(defvar arrow-right-2 (create-image (arrow-right-xpm color2 "None") 'xpm t :ascent 'center))
(defvar arrow-left-1  (create-image (arrow-left-xpm color2 color1) 'xpm t :ascent 'center))
(defvar arrow-left-2  (create-image (arrow-left-xpm "None" color2) 'xpm t :ascent 'center))

(setq-default mode-line-format
              (list  '(:eval (concat (propertize " %* %4l:%2c " 'face 'mode-line-color-1)
                                     (propertize " " 'display arrow-right-1)))
                     '(:eval (concat (propertize " %b  " 'face 'mode-line-color-2)
                                     (propertize " " 'display arrow-right-2)))

                     " "
                     'mode-line-mule-info

                     ;; Justify right by filling with spaces to right fringe - 16
                     ;; (16 should be computed rahter than hardcoded)
                     '(:eval (propertize " " 'display '((space :align-to (- right-fringe 45))) 'face 'mode-line-color-1))

                     '(:eval (concat (propertize " " 'display arrow-left-2)
                                     (propertize " %m " 'face 'mode-line-color-2)))
                     '(:eval (concat (propertize " " 'display arrow-left-1)
                                     (propertize " " 'face 'mode-line-color-1)))

                     'minor-mode-alist
                     ))

(make-face 'mode-line-color-1)
(set-face-attribute 'mode-line-color-1 nil
                    :foreground "#fff"
                    :background blue)

(make-face 'mode-line-color-2)
(set-face-attribute 'mode-line-color-2 nil
                    :foreground "#fff"
                    :background green)

(set-face-attribute 'mode-line nil
                    :foreground "#fff"
                    :background blue
                    :box nil)
(set-face-attribute 'mode-line-inactive nil
                    :foreground "#fff"
                    :background blue)
