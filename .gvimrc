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
" set guioptions-=r "右カーソルバー


" ステータスライン下の行数
set cmdheight=1

" ========== 色の設定 ==========
"カラースキーマを設定
" colorscheme murphyNS
" colorscheme wombat-noItalic
colorscheme Tomorrow-Night-Bright




" ========== タブの設定 ==========
" 個別のタブの表示設定をします
function! GuiTabLabel()
  " タブで表示する文字列の初期化をします
  let l:label = ''

  " タブに含まれるバッファ(ウィンドウ)についての情報をとっておきます。
  let l:bufnrlist = tabpagebuflist(v:lnum)

  " 表示文字列にバッファ名を追加します
  " パスを全部表示させると長いのでファイル名だけを使います 詳しくは help fnamemodify()
  let l:bufname = fnamemodify(bufname(l:bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')
  " バッファ名がなければ No title としておきます。ここではマルチバイト文字を使わないほうが無難です
  let l:label .= l:bufname == '' ? 'No title' : l:bufname

  " タブ内にウィンドウが複数あるときにはその数を追加します(デフォルトで一応あるので)
  let l:wincount = tabpagewinnr(v:lnum, '$')
  if l:wincount > 1
    let l:label .= '[' . l:wincount . ']'
  endif

  " このタブページに変更のあるバッファがるときには '[+]' を追加します(デフォルトで一応あるので)
  for bufnr in l:bufnrlist
    if getbufvar(bufnr, "&modified")
      let l:label .= '[+]'
      break
    endif
  endfor

  " 表示文字列を返します
  return l:label
endfunction

" guitablabel に上の関数を設定します
" その表示の前に %N というところでタブ番号を表示させています
set guitablabel=%N:\ %{GuiTabLabel()}


" ========== 環境別の設定 ==========

if has("win32")
    " Windows用設定
    " set guifont=MS_Gothic:h10:cSHIFTJIS 
    " set guifont=VL_Gothic:h9:cSHIFTJIS 
    set guifont=MeiryoKe_Console:h9:cSHIFTJIS
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
