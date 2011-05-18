" ########## vimrc ##########
"
"------------------------------------
" vundle
"------------------------------------
set rtp+=~/.vim/vundle.git/
call vundle#rc()

" 使用するプラグインの指定
"" vim-scriptから
Bundle 'unite-colorscheme'
Bundle 'unite-font'
Bundle 'VimClojure'
"" githubから
Bundle 'thinca/vim-quickrun'
Bundle 'basyura/TwitVim'
Bundle 'Shougo/neocomplcache'
Bundle 'scrooloose/nerdcommenter'
Bundle 'Shougo/unite.vim'
Bundle 'Sixeight/unite-grep'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'
Bundle 'mattn/webapi-vim'
Bundle 'tyru/vim-altercmd'
Bundle 'kana/vim-operator-user'
Bundle 'kana/vim-operator-replace'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-surround'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'ewiplayer/vim-scala'
Bundle 'tsukkee/lingr-vim'
Bundle 'thinca/vim-poslist'
Bundle 'h1mesuke/unite-outline'
Bundle 'mattn/googletasks-vim' 
Bundle 'smoothPageScroll.vim'
Bundle 'Processing'
" BUndle 'ujihisa/vital.vim'

"-------------------------------------------------------------------------------
" 基本設定 Basics
"-------------------------------------------------------------------------------

" キーマップリーダー
let mapleader = ","


"ファイルタイプ別セッティングON
filetype plugin indent on

" エンコーディング関連 Encoding
set ffs=unix,dos,mac " 改行文字
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp,ucs-2,latin1
set encoding=utf-8 " デフォルトエンコーディング

" 文字コード関連
" from ずんWiki http://www.kawaz.jp/pukiwiki/?vim#content_1_7
" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
" iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
" iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
" fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
" 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif


" 各種設定
set nocompatible                 " vi互換なし
set scrolloff=5                  " スクロール時の余白確保
set textwidth=0                  " 一行に長い文章を書いていても自動折り返しをしない
set nobackup                     " バックアップ取らない
set autoread                     " 他で書き換えられたら自動で読み直す
set noswapfile                   " スワップファイル作らない
set hidden                       " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set formatoptions=lmoq           " テキスト整形オプション，マルチバイト系を追加
set vb t_vb=                     " ビープをならさない
set browsedir=buffer             " Exploreの初期ディレクトリ
set whichwrap=b,s,h,l,<,>,[,]    " カーソルを行頭、行末で止まらないようにする
"set showcmd                      " コマンドをステータス行に表示
set showmode                     " 現在のモードを表示
set viminfo='50,<1000,s100,\"50  " viminfoファイルの設定
set modelines=0                  " モードラインは無効

set title
set titlestring=Vim:\ %f\ %h%r%m

" ターミナルでマウスを使用できるようにする
set mouse=a
set guioptions+=a
set ttymouse=xterm2

" insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" 矩形選択で自由に移動する
set virtualedit+=block

"-------------------------------------------------------------------------------
" 表示設定
"-------------------------------------------------------------------------------
"カラースキーマを設定→gvimrcへ
"colorscheme murphy

"hilight
syntax on
" ファイルタイプ
filetype on
"行番号を表示する
set number
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
"ステータスラインを常に表示
set laststatus=2
" ステータスラインに表示する情報の指定
set statusline=%n\:\ %y\[%{(&fenc!=''?&fenc:&enc).'\:'.&ff.'\]'}%m\ %F%r%=<%l/%L:%p%%>
" ステータスライン下の行数
set cmdheight=1
" 一定時間放置するとカーソル行ハイライト
augroup vimrc-auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
  autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
  autocmd WinEnter * call s:auto_cursorline('WinEnter')
  autocmd WinLeave * call s:auto_cursorline('WinLeave')

  let s:cursorline_lock = 0
  function! s:auto_cursorline(event)
    if a:event ==# 'WinEnter'
      setlocal cursorline
      let s:cursorline_lock = 2
    elseif a:event ==# 'WinLeave'
      setlocal nocursorline
    elseif a:event ==# 'CursorMoved'
      if s:cursorline_lock
        if 1 < s:cursorline_lock
          let s:cursorline_lock = 1
        else
          setlocal nocursorline
          let s:cursorline_lock = 0
        endif
      endif
    elseif a:event ==# 'CursorHold'
      setlocal cursorline
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END

" コマンドのタブ補完モード
set wildmenu
set wildmode=list,full

"挿入モード時、ステータスラインの色を変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=Red guibg=#ffffff
autocmd InsertLeave * highlight StatusLine guifg=#ffffff guibg=#333333
augroup END

" function! GetB()
"   let c = matchstr(getline('.'), '.', col('.') - 1)
"   let c = iconv(c, &enc, &fenc)
"   return String2Hex(c)
" endfunction


" 全角空白と行末の空白の色を変える
highlight WideSpace ctermbg=blue guibg=blue
highlight EOLSpace ctermbg=red guibg=red
function! s:HighlightSpaces()
  match WideSpace /　/
  match EOLSpace /\s\+$/
endf
call s:HighlightSpaces()


" カーソル行をハイライト
" set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END


"-------------------------------------------------------------------------------
" カラー関連 Colors
"-------------------------------------------------------------------------------

" ターミナルタイプによるカラー設定
if &term =~ "xterm-debian" || &term =~ "xterm-xfree86" || &term =~ "xterm-256color"
 " set t_Co=16
 set t_Co=256
 set t_Sf=[3%dm
 set t_Sb=[4%dm
elseif &term =~ "xterm-color"
 set t_Co=8
 set t_Sf=[3%dm
 set t_Sb=[4%dm
endif

"ポップアップメニューのカラーを設定
hi Pmenu guibg=#666666
hi PmenuSel guibg=#8cd0d3 guifg=#666666
hi PmenuSbar guibg=#333333

" 補完候補の色づけ for vim7
hi Pmenu ctermbg=white ctermfg=darkgray
hi PmenuSel ctermbg=blue ctermfg=white
hi PmenuSbar ctermbg=0 ctermfg=9

"背景色は黒っぽい
" set background=light


" ========== インデント設定 ==========
"新しい行のインデントを現在行と同じにする
set autoindent
"タブの代わりに空白文字を挿入する
set expandtab
"シフト移動幅
set shiftwidth=2
" オートインデント時の空白の数
set softtabstop=2
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
set smarttab
"ファイル内の <Tab> が対応する空白の数
set tabstop=2
"新しい行を作ったときに高度な自動インデントを行う
set smartindent

" ========== yank設定 ==========
"クリップボードをOSと連携
set clipboard=unnamed

" ========== grep設定 ==========
" vimgrep時に自動でQuickFixを開く設定
au QuickfixCmdPost vimgrep cw

" ========== Align設定 ==========
" Alignを日本語環境で使用するための設定
let g:Align_xstrlen = 3

" ========== その他設定 ==========
" for MRU
let MRU_Max_Entries=100

" ========== マルチバイトを使ううえで ==========
" 記号文字の表示がおかしくならないように
set ambiwidth=double


"-------------------------------------------------------------------------------
" プラットホーム依存の特別な設定
"-------------------------------------------------------------------------------
if has('mac')
  " Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
  set iskeyword=@,48-57,_,128-167,224-235
endif


"-------------------------------------------------------------------------------
" 検索設定 Search
"-------------------------------------------------------------------------------
set wrapscan   " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase  " 検索文字列に大文字が含まれている場合は区別して検索する
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト




"-------------------------------------------------------------------------------
" プラグインの設定類
"-------------------------------------------------------------------------------

"------------------------------------
" neocomplecache.vim
"------------------------------------
" NeoComplCacheを有効にする
let g:neocomplcache_enable_at_startup = 1
" smarrt case有効化。 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1
" camle caseを有効化。大文字を区切りとしたワイルドカードのように振る舞う
let g:neocomplcache_enable_camel_case_completion = 1
" _(アンダーバー)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1
" シンタックスをキャッシュするときの最小文字長を3に
let g:neocomplcache_min_syntax_length = 3
" neocomplcacheを自動的にロックするバッファ名のパターン
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" -入力による候補番号の表示
let g:neocomplcache_enable_quick_match = 1
" 補完候補の一番先頭を選択状態にする(AutoComplPopと似た動作)
let g:neocomplcache_enable_auto_select = 0
" dict
let g:neocomplcache_dictionary_filetype_lists = {
  \ 'default' : '',
  \ 'scala' : $HOME . '/.vim/dict/scala.dict',
  \ }

" 補完を選択しpopupを閉じる
inoremap <expr><C-y> neocomplcache#close_popup()
" 補完をキャンセルしpopupを閉じる
" inoremap <expr><C-e> neocomplcache#cancel_popup()
" TABで補完できるようにする
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" undo
inoremap <expr><C-g>     neocomplcache#undo_completion()
" 補完候補の共通部分までを補完する
inoremap <expr><C-l> neocomplcache#complete_common_string()
" SuperTab like snippets behavior.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
" C-kを押すと行末まで削除
inoremap <C-k> <C-o>D
" C-nでneocomplcache補完
inoremap <expr><C-n>  pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"
" C-pでkeyword補完
inoremap <expr><C-p> pumvisible() ? "\<C-p>" : "\<C-p>\<C-n>"
" 補完候補が出ていたら確定、なければ改行
inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-x><C-o> &filetype == 'vim' ? "\<C-x><C-v><C-p>" : neocomplcache#manual_omni_complete()


"------------------------------------
" Nerd_commenter設定
"------------------------------------
" Nerd_Commenter の基本設定
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1

" Nerd_commenterのキーバインド
"<Leader>cc でコメントをトグル
nmap <Leader>cc <Plug>NERDCommenterToggle
vmap <Leader>cc <Plug>NERDCommenterToggle

"<Leader>/aで行末にコメントを追加して文字列入力
nmap <Leader>ca <Plug>NERDCommenterAppend

"<Leader>/9で行末までコメント
nmap <leader>c9 <Plug>NERDCommenterToEOL

"<Leader>/s でsexyなコメント
vmap <Leader>cs <Plug>NERDCommenterSexy

"<Leader>/b でブロックをコメント
vmap <Leader>cb <Plug>NERDCommenterMinimal



"------------------------------------
" pydiction用設定
"------------------------------------
filetype plugin on
autocmd FileType python let g:pydiction_location = '~/vim/pydiction/complete-dict'
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl expandtab tabstop=4 shiftwidth=4 softtabstop=4


"Ctr+Pで編集中のpython実行
function! s:ExecPy()
    exe "!" . &ft . " %"
        :endfunction
            command! Exec call <SID>ExecPy()
                autocmd FileType python map <silent> <C-p> :call <SID>ExecPy()<CR>


"------------------------------------
" unite.vim
"------------------------------------
" The prefix key.
nnoremap    [unite]   <Nop>
nmap    , [unite]

nnoremap [unite]u  :<C-u>Unite<Space>

nnoremap <silent> [unite];  :<C-u>Unite -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> <C-u>  :<C-u>Unite -buffer-name=files buffer file_mru bookmark file_rec<CR>
inoremap <silent> <C-u>  <Esc>:<C-u>Unite -buffer-name=files buffer file_mru bookmark file_rec<CR>

nnoremap <silent> [unite]f  :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <C-x><C-f>  :<C-u>UniteWithBufferDir -buffer-name=files file<CR>

nnoremap <silent> [unite]b  :<C-u>Unite -auto-preview buffer<CR>
nnoremap <silent> <C-x><C-b>  :<C-u>Unite -auto-preview buffer<CR>

nnoremap <silent> [unite]m  :<C-u>Unite file_mru<CR>

nnoremap <silent> [unite]g  :<C-u>Unite grep<CR>

" レジスタ一覧
nnoremap <silent> <C-p> :<C-u>Unite -buffer-name=register register<CR>
" 位置一覧
nnoremap <silent> <C-i> :<C-u>Unite -auto-preview poslist<CR>
" アウトライン
nnoremap <silent> <C-o> :<C-u>Unite -auto-preview outline<CR>


autocmd FileType unite call s:unite_my_settings()

function! s:unite_my_settings()"{{{
  imap <buffer> jj      <Plug>(unite_insert_leave)
  nnoremap <silent><buffer> <C-k> :<C-u>call unite#mappings#do_action('preview')<CR>
  imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
  " unite開始時にinsertモードにするか 0ならしない
  let g:unite_enable_start_insert = 0
  let g:unite_source_file_mru_limit = 200
endfunction"}}}




"------------------------------------
" surround.vim
"------------------------------------
" s, ssで選択範囲を指定文字でくくる
nmap s <Plug>Ysurround
nmap ss <Plug>Yssurround




"------------------------------------
" grep.vim
"------------------------------------
" :Gb <args> でGrepBufferする
command! -nargs=1 Gb :GrepBuffer <args>
" カーソル下の単語をGrepBufferする
nnoremap <C-g><C-b> :<C-u>GrepBuffer<Space><C-r><C-w><Enter>



"------------------------------------
" MiniBufExplorer
"------------------------------------
"set minibfexp
let g:miniBufExplMapWindowNavVim=1 "hjklで移動
let g:miniBufExplSplitBelow=0  " Put new window above
let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplModSelTarget=1
let g:miniBufExplSplitToEdge=1
let g:miniBufExplMaxSize = 10

":TmでMiniBufExplorerの表示トグル
command! Mt :TMiniBufExplorer


"------------------------------------
" scala
"------------------------------------
" scala用色
hi scalaNew gui=underline
hi scalaMethodCall gui=italic
hi scalaValName gui=underline
hi scalaVarName gui=underline




"------------------------------------
" vimshell
"------------------------------------
" ,is: シェルを起動
nnoremap <silent> <Leader>s :VimShell<CR>
" pythonを非同期で起動
nnoremap <silent> <Leader>sp :VimShellInteractive python<CR>
" scalaを非同期で起動
nnoremap <silent> <Leader>ss :VimShellInteractive scala<CR>
" clojureを非同期で起動
nnoremap <silent> <Leader>sc :VimShellInteractive clj<CR>
" <Leader>sr: 非同期で開いたインタプリタに現在の行を評価させる
vmap <silent> <Leader>sr :VimShellSendString<CR>
" 選択中に<Leader>sr: 非同期で開いたインタプリタに選択行を評価させる
nnoremap <silent> <Leader>sr <S-v>:VimShellSendString<CR>
nnoremap <silent> <C-s><C-r> <S-v>:VimShellSendString<CR>
inoremap <silent> <C-s><C-r> <Esc><S-v>:VimShellSendString<CR>

" 左プロンプト表示
let g:vimshell_prompt = '% '
" 右プロンプト表示
let g:vimshell_right_prompt = 'getcwd()'




"------------------------------------
" twit-vim via basyura
"------------------------------------
let twitvim_count = 40
nnoremap <Leader>tp :<C-u>PosttoTwitter<CR>
nnoremap <Leader>tf :<C-u>FriendsTwitter<CR><C-w>j
nnoremap <Leader>tu :<C-u>UserTwitter<CR><C-w>j
nnoremap <Leader>tr :<C-u>RepliesTwitter<CR><C-w>j

autocmd FileType twitvim call s:twitvim_my_settings()
function! s:twitvim_my_settings()
  set nowrap
endfunction


if has('win32')
  let twitvim_proxy = "192.168.1.8:8080"
endif

"------------------------------------
" kana-vim-operator-replace
"------------------------------------
map R <Plug>(operator-replace)


"------------------------------------
" vim-poslist
"------------------------------------
" nmap <C-o> <Plug>(poslist-prev_pos)
" nmap <C-i> <Plug>(poslist-next-pos)


"------------------------------------
" smoothPageScroll.vim
"------------------------------------
map <C-f> :call SmoothPageScrollDown()<CR>
map <C-b> :call SmoothPageScrollUp()<CR> 
let g:smooth_page_scroll_delay = 0.5


"-------------------------------------------------------------------------------
" キーマッピング
"-------------------------------------------------------------------------------

" キーを2つ以上にマッピングする際の待ち時間(ms)
set timeoutlen=500

"Escの2回押しでハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>

" <Esc>*3でウィンドウをひとつに
nnoremap <Esc><Esc><Esc> :only<CR>

"選択した文字列を検索
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

"選択した文字列を置換
vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>

"s*でカーソル下のキーワードを置換
nnoremap <expr> s* ':%substitute/\<' . expand('<cword>') . '\>/'

" Ctrl-^でヘルプ
nnoremap <C-^>  :<C-u>help<Space>
" カーソル下のキーワードをヘルプでひく
nnoremap <C-^><C-^> :<C-u>help<Space><C-r><C-w><Enter>


" gj gk とj kを入れ替え
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" 最後に変更したテキストの選択
nnoremap gc `[v`]
vnoremap gc :<C-u>normal gc<Enter>
onoremap gc :<C-u>normal gc<Enter>

" コンマの後に自動的にスペースを挿入
" inoremap , ,<Space>

" XMLの閉タグを自動挿入
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
augroup END

" Visualモードでのpで選択範囲をレジスタの内容に置き換える
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>


" F2で前のバッファ
map <F2> <ESC>:bp<CR>
" F3で次のバッファ
map <F3> <ESC>:bn<CR>
" F4でバッファを削除する
map <F4> <ESC>:bw<CR>

" M-bで前のバッファ
map <M-b> <ESC>:bp<CR>
" M-nで次のバッファ
map <M-n> <ESC>:bn<CR>
" M-dでバッファを削除する
map <M-d> <ESC>:bw<CR>

" 0, 9で行頭、行末へ
nmap 1 0
nmap 0 ^
nmap 9 $

" y9で行末までヤンク
nmap y9 y$
nnoremap Y y$
" y0で行頭までヤンク
nmap y0 y^
" v9で行末まで選択
nmap v9 v$


" 挿入モードでCtrl+kを押すとクリップボードの内容を貼り付けられるように
imap <C-K>  <ESC>"*pa


" Ev/Rvでvimrcの編集と反映
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC
command! Rgv source $MYGVIMRC


" 日時の自動入力
inoremap <expr> <Leader>df strftime('%Y/%m/%d %H:%M:%S')
inoremap <expr> <Leader>dd strftime('%Y/%m/%d')
inoremap <expr> <Leader>dt strftime('%H:%M:%S')

" 括弧を自動補完
"inoremap { {}<LEFT>
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>
"vnoremap { "zdi^V{<C-R>z}<ESC>
"vnoremap [ "zdi^V[<C-R>z]<ESC>
"vnoremap ( "zdi^V(<C-R>z)<ESC>
"vnoremap " "zdi^V"<C-R>z^V"<ESC>
"vnoremap ' "zdi'<C-R>z'<ESC>



" CTRL-hjklでウィンドウ移動
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

if has("win32")
  " altにキーを割り当てるためメニューバーを消す
  set guioptions-=m
endif

if has("mac")
  " optionキーを使う
  set macmeta
endif

" insert mode での移動
map <C-e> <END>
imap <C-e> <END>
map <C-a> <HOME>
imap <C-a> <HOME>

" インサートモードでもhjklで移動
imap <M-j> <Down>
imap <M-k> <Up>
imap <M-h> <Left>
imap <M-l> <Right>

" インサートモードでもundo
imap <M-u> <Esc>:undo<CR> i

" インサートモードでもdd
imap <M-d><M-d> <Esc>dd i

" mkでバッファを殺す
nmap mk :bd<CR>
nmap MK :bd!<CR>

" Exploreを開く
" map <C-x><C-f> :Explore<CR>

" 保存
map <C-x><C-s> :w<CR>
imap <C-x><C-s> <Esc>:w<CR>i

" xのヤンクは使わないのでxレジスタへ
nnoremap x "xx

" カッコ移動を楽に
onoremap ) t)
onoremap ( t(
vnoremap ) t)
vnoremap ( t(

" tabで分割移動
nnoremap <Tab> <C-w>w



"-------------------------------------------------------------------------------
" コマンド定義類
"-------------------------------------------------------------------------------
" キーマップ全表示
" 全てのマッピングを表示
" :AllMaps
" 冒頭で言った1のケースのように現在のバッファで定義されたマッピングのみ表示
" :AllMaps <buffer>
" どのスクリプトで定義されたかの情報も含め表示
" :verbose AllMaps <buffer>
command!
\   -nargs=* -complete=mapping
\   AllMaps
\   map <args> | map! <args> | lmap <args>

command! -nargs=+ Allnoremap
\ execute 'noremap' <q-args>
\ | execute 'noremap!' <q-args>

command! -nargs=+ Allunmap
\ execute 'unmap' <q-args>
\ | execute 'unmap!' <q-args>


" Cr in Insert Mode always means newline
function! CrInInsertModeAlwaysMeansNewline()
  "let a = (exists('b:did_indent') ? "\<C-f>" : "") . "\<CR>X\<BS>"
  let a = "\<CR>X\<BS>"
  return pumvisible() ? neocomplcache#close_popup() . a : a
endfunction
"inoremap <expr> <CR> pumvisible() ? neocomplcache#close_popup()."\<C-f>\<CR>X\<BS>" : "\<C-f>\<CR>X\<BS>"
inoremap <expr> <CR> CrInInsertModeAlwaysMeansNewline()


" 戦闘力計測
function! Scouter(file, ...)
  let pat = '^\s*$\|^\s*"'
  let lines = readfile(a:file)
  if !a:0 || !a:1
    let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
  endif
  return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
\        echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)
command! -bar -bang -nargs=? -complete=file GScouter
\        echo Scouter(empty(<q-args>) ? $MYGVIMRC : expand(<q-args>), <bang>0)

