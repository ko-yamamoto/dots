;; You need to install fringe-helper.el
(require 'git-gutter-fringe)

;; 色変更
(set-face-foreground 'git-gutter-fr:added "#95D9FF")
(set-face-foreground 'git-gutter-fr:modified "#eab700")
(set-face-foreground 'git-gutter-fr:deleted "#c82829")
;; 形変更
(fringe-helper-define 'git-gutter-fr:added nil
  "...XXXX.."
  "...XXXX.."
  "...XXXX.."
  "...XXXX.."
  "...XXXX.."
  "...XXXX.."
  "...XXXX.."
  "...XXXX..")
(fringe-helper-define 'git-gutter-fr:deleted nil
  "...XXXX.."
  "...XXXX.."
  "...XXXX.."
  "...XXXX.."
  "...XXXX.."
  "...XXXX.."
  "...XXXX.."
  "...XXXX..")
(fringe-helper-define 'git-gutter-fr:modified nil
  "...XXXX.."
  "...XXXX.."
  "...XXXX.."
  "...XXXX.."
  "...XXXX.."
  "...XXXX.."
  "...XXXX.."
  "...XXXX..")
