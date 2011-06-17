if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.scala        setfiletype scala
  au! BufRead,BufNewFile *.clj          setfiletype clojure
  au! BufRead,BufNewFile *.md          setfiletype markdown
augroup END
