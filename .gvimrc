" ========== 全体的な見た目の設定 ==========

" ウィンドウを大きくして起動
if has("win32")
    " au GUIEnter * simalt ~x
    au GUIEnter * set lines=55
    au GUIEnter * set columns=100
else
    au GUIEnter * set lines=45
    au GUIEnter * set columns=150
endif

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

" ========== 色の設定 ==========
"カラースキーマを設定
" colorscheme murphyNS
" colorscheme wombat-noItalic
colorscheme Tomorrow-Night-Bright


" ========== 環境別の設定 ==========

if has("win32")
    " Windows用設定
    " set guifont=MS_Gothic:h10:cSHIFTJIS 
    " set guifont=VL_Gothic:h9:cSHIFTJIS 
    set guifont=MeiryoKe_Console:h10:cSHIFTJIS
    " set transparency=220 " 透明度を指定
    au GUIEnter * set transparency=220

elseif has("mac")
    " Mac用設定
    set guifont=VL-Gothic-Regular:h12

elseif has("unix")
 	  set gfn=MeiryoKe_Console\ 11
endif

if has('gui_macvim')
    " MacVim用設定
    " set showtabline=2 " タブを常に表示
    set showtabline=0 " タブを非表示
    set imdisable " IMを無効化
    au GUIEnter * set transparency=20 " 透明度を指定
    set antialias
endif

" GUIの時はフルスクリーンで起動
"if has("gui_running")
"  set fuoptions=maxvert,maxhorz
"  au GUIEnter * set fullscreen
"endif

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
