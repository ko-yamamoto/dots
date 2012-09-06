" ========== 全体的な見た目の設定 ==========

" ウィンドウを大きくして起動
if has("win32")
    " au GUIEnter * simalt ~x
    au GUIEnter * set lines=55
    au GUIEnter * set columns=100
" else
    " au GUIEnter * set lines=45
    " au GUIEnter * set columns=150
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

set novisualbell

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


" タブページを常に表示
set showtabline=2
" gVimでもテキストベースのタブページを使う
set guioptions-=e

set tabline=%!MakeTabLine()

function! MakeTabLine() "{{{
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let sep = ' '  " タブ間の区切り
  let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
  let info = ''  " 好きな情報を入れる

  "FoldCCnavi
  if exists('*FoldCCnavi')
    let info .= '%#TabLineInfo#'.substitute(FoldCCnavi()[-60:],'\s>\s','%#TabLineFill#> %#TabLineInfo#','g').'%0* '
  endif

  "カレントディレクトリ
  let info .= '['.fnamemodify(getcwd(), ":~") . ']'

  return tabpages . '%=' . info  " タブリストを左に、情報を右に表示
endfunction "}}}


function! s:tabpage_label(tabpagenr) "{{{
  "rol;各タブページのカレントバッファ名+αを表示
  let title = gettabvar(a:tabpagenr, 'title') "タブローカル変数t:titleを取得
  if title !=# ''
    return title
  endif

  " タブページ内のバッファのリスト
  let bufnrs = tabpagebuflist(a:tabpagenr)

  " カレントタブページかどうかでハイライトを切り替える
  let hi = a:tabpagenr is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

  " バッファが複数あったらバッファ数を表示
  let no = len(bufnrs)
  if no is 1
    let no = ''
  endif
  " タブページ内に変更ありのバッファがあったら '+' を付ける
  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '+' : ''
  let nomod = (no . mod) ==# '' ? '' : '['.no.mod.']'

  " カレントバッファ
  let curbufnr = bufnrs[tabpagewinnr(a:tabpagenr) - 1]  " tabpagewinnr() は 1 origin
  let fname = fnamemodify(bufname(curbufnr), ':t')
  let fname = fname is '' ? 'No title' : fname "バッファが空ならNo title

  let label = fname . nomod

  return '%' . a:tabpagenr . 'T' . hi .a:tabpagenr.': '. curbufnr.'-' . label . '%T%#TabLineFill#'
endfunction "}}}


" ========== 環境別の設定 ==========

if has("win32")
    " Windows用設定
    " set guifont=MS_Gothic:h10:cSHIFTJIS 
    " set guifont=VL_Gothic:h9:cSHIFTJIS 
    set guifont=MeiryoKe_Console:h9:cSHIFTJIS
    set guifont=ricty:h10:cSHIFTJIS
    " set transparency=220 " 透明度を指定
    au GUIEnter * set transparency=220

elseif has("mac")
    " Mac用設定
    " set guifont=VL-Gothic-Regular:h12
    set guifont=ricty:h13

elseif has("unix")
       " set gfn=MeiryoKe_Console\ 11
 	  set gfn=ricty\ 11
endif

if has('gui_macvim')
    " MacVim用設定
    set showtabline=2 " タブを常に表示
    " set showtabline=0 " タブを非表示
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
