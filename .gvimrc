" ========== Color Scheme ==========
let g:hybrid_use_Xresources = 1
colorscheme hybrid



" ========== メニューバー関連の設定 ==========

" menu setting
set guioptions-=T "ツールバーなし
set guioptions-=m "メニューバーなし
set guioptions-=R
set guioptions-=l "左スクロールバーなし
set guioptions-=L
set guioptions-=b "下スクロールバーなし
set guioptions-=r "右カーソルバー


" ステータスライン下の行数
set cmdheight=1
" 画面でベルしない
set novisualbell






" 動作・挙動設定 """"""""""""""""""""""""""""""""""""""""""""""
" クリップボードを OS と共有
set guioptions+=a




" ========== 環境別の設定 ==========

if has("win32")
    " Windows用設定
    set guifont=ricty:h10:cSHIFTJIS
    " 透明度を指定
    au GUIEnter * set transparency=220

elseif has("mac")
    " Mac用設定
    set guifont=ricty:h18

elseif has("unix")
    set gfn=ricty\ 10
endif

if has('gui_macvim')
    " MacVim用設定
    set showtabline=2 " タブを常に表示
    " set showtabline=0 " タブを非表示
    set imdisable " IMを無効化
    au GUIEnter * set transparency=15 " 透明度を指定
    set antialias
endif


" gVimの位置とサイズを記憶
let g:save_window_file = expand('~/.vim/.vimwinpos')
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
