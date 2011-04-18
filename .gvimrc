" ========== 全体的な見た目の設定 ==========

" ウィンドウを大きくして起動
if has("win32")
    au GUIEnter * simalt ~x
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


" ========== 環境別の設定 ==========

if has("win32")
    " Windows用設定
    set guifont=MS_Gothic:h10:cSHIFTJIS 

elseif has("mac")
    " Mac用設定
    set guifont=VL-Gothic-Regular:h12
endif

if has('gui_macvim')
    " MacVim用設定
    " set showtabline=2 " タブを常に表示
    set showtabline=0 " タブを非表示
    set imdisable " IMを無効化
    set transparency=20 " 透明度を指定
    set antialias
endif

" GUIの時はフルスクリーンで起動
"if has("gui_running")
"  set fuoptions=maxvert,maxhorz
"  au GUIEnter * set fullscreen
"endif


" ========== 色の設定 ==========
"カラースキーマを設定
" colorscheme murphyNS
colorscheme wombat


