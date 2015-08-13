" colorscheme Tomorrow-Night-Eighties
" colorscheme lucius
" LuciusDarkLowContrast
" colorscheme hybrid
" colorscheme solarized
" set background=light
colorscheme pastel-light

"フォントの設定
" set guifont=源真ゴシック等幅\ 13
set guifont=M+\ 1mn\ 13

" メニューバーを非表示にする
set guioptions-=m
" ツールバーを非表示にする
set guioptions-=T
" 左右のスクロールバーを非表示にする
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
" 水平スクロールバーを非表示にする
set guioptions-=b
" gVimでもテキストベースのタブページを使う
set guioptions-=e
" 行数表示
set nu

" コマンドラインの行数
set cmdheight=1

" カーソルを行頭、行末で止まらないようにする  
set whichwrap=b,s,h,l,<,>,[,]

" ウィンドウ位置と大きさを保存
let g:save_window_file = expand('~/.vimwinpos')
augroup SaveWindow
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = [
      \ 'set columns=' . &columns,
      \ 'set lines=' . &lines,
      \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
      \ ]
    call writefile(options, g:save_window_file)
  endfunction
augroup END

if filereadable(g:save_window_file)
  execute 'source' g:save_window_file
endif


