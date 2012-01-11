" ########## vimrc ##########
"
"------------------------------------
" neovundle
"------------------------------------
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif

" NeoBundle自身
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'

" プラグインのプラグイン
NeoBundle 'Shougo/vimproc'
NeoBundle 'mattn/webapi-vim'

" ファイルセレクタ・移動系
" unite.vim
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'git://github.com/ujihisa/unite-font.git'
NeoBundle 'git://github.com/h1mesuke/unite-outline.git'

NeoBundle 'git://github.com/kien/ctrlp.vim.git'

" shell/filer
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimfiler'

" 入力/開発補助
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'thinca/vim-poslist'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tyru/vim-altercmd'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-operator-replace'
NeoBundle 'git://github.com/kana/vim-smartword.git'
NeoBundle 'git://github.com/vim-scripts/occur.vim.git'
NeoBundle 'git://github.com/vim-scripts/Align.git'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'git://github.com/kana/vim-smartword.git'
NeoBundle 'git://github.com/kana/vim-smartchr.git'
NeoBundle 'git://github.com/kana/vim-arpeggio.git'
NeoBundle 'git://github.com/vimtaku/vim-mlh.git'
" NeoBundle 'git@github.com:nishikawasasaki/taglist.vim.git'
NeoBundle 'git://github.com/majutsushi/tagbar.git'


" 見た目に影響
NeoBundle 'git://github.com/vim-scripts/smoothPageScroll.vim.git'
NeoBundle 'git://github.com/thinca/vim-fontzoom.git'
NeoBundle 'git://github.com/nathanaelkane/vim-indent-guides.git'
" NeoBundle 'fholgado/minibufexpl.vim'
NeoBundle 'git://github.com/godlygeek/csapprox.git'
NeoBundle 'git://github.com/kien/rainbow_parentheses.vim.git'



" 言語関連
NeoBundle 'git://github.com/derekwyatt/vim-scala.git'
NeoBundle 'git://github.com/vim-scripts/VST.git'
NeoBundle 'git://github.com/vim-scripts/JSON.vim.git'
" NeoBundle 'VimClojure'
" NeoBundle 'Processing'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'git://github.com/vim-ruby/vim-ruby.git'

" その他
NeoBundle 'git://github.com/tyru/open-browser.vim.git'
NeoBundle 'git://github.com/vim-scripts/TwitVim.git'
NeoBundle 'fuenor/qfixhowm'
NeoBundle 'git://github.com/mattn/learn-vimscript.git'
NeoBundle 'git://github.com/mattn/lisper-vim'
" NeoBundle 'git://github.com/choplin/unite-vim_hacks.git'
" NeoBundle 'git://github.com/basyura/twibill.vim.git'
" NeoBundle 'git://github.com/basyura/unite-twitter.git'
NeoBundle 'git://github.com/mattn/hahhah-vim.git'
NeoBundle 'git://github.com/basyura/twibill.vim.git'
NeoBundle 'git://github.com/basyura/TweetVim.git'
NeoBundle 'git://github.com/pasela/unite-webcolorname.git'





filetype plugin on
filetype indent on

"-------------------------------------------------------------------------------
" 基本設定 Basics
"-------------------------------------------------------------------------------

" キーマップリーダー
" let mapleader = ","
let mapleader = " "


"ファイルタイプ別セッティングON
filetype plugin indent on

" エンコーディング関連 Encoding
set ffs=unix,dos,mac " 改行文字
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp,ucs-2,latin1
set encoding=utf-8 " デフォルトエンコーディング
if has("win32")
    set termencoding=cp932
else
    set termencoding=utf-8
endif

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
set history=100

set title
set titlestring=Vim:\ %f\ %h%r%m

" ターミナルでマウスを使用できるようにする
" set mouse=a
" set guioptions+=a
" set ttymouse=xterm2

" insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" 矩形選択で自由に移動する
set virtualedit+=block

" 常に開いているファイルのディレクトリをカレントリディレクトリにする
au   BufEnter *   execute ":lcd " . expand("%:p:h")

" ％拡張のmatchhit.vimを利用
:source $VIMRUNTIME/macros/matchit.vim

"-------------------------------------------------------------------------------
" 表示設定
"-------------------------------------------------------------------------------

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
set statusline=%n\:\ %y\[%{(&fenc!=''?&fenc:&enc).'\:'.&ff.'\]'}%m\ %F%r%=<%l/%L:%p%%>%=%{g:HahHah()}
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

if has("autocmd")
    " カーソル位置を記憶する
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
endif

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
 set t_Co=256
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

"カラースキーマを設定→gvimrcへ
"colorscheme murphy

if has("unix")
  " unix(linux)の場合256色モードでカラースキーマ指定
  set t_Co=256
  colorscheme wombat256mod
endif


" ========== インデント設定 ==========
"新しい行のインデントを現在行と同じにする
set autoindent
"タブの代わりに空白文字を挿入する
set expandtab
"ファイル内の <Tab> が対応する空白の数
set tabstop=4
"シフト移動幅
set shiftwidth=4
" オートインデント時の空白の数
set softtabstop=4
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
set smarttab
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
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
\ 'default' : '',
\ 'vimshell' : $HOME.'/.vimshell_hist',
\ 'ruby' : $HOME.'/.vim/dict/ruby.dict',
\ 'scala' : $HOME . '/.vim/dict/scala.dict'
\ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
" imap <C-k> <Plug>(neocomplcache_snippets_expand)
" smap <C-k> <Plug>(neocomplcache_snippets_expand)
" inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
" inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
"inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Enable heavy omni completion.
" if !exists('g:neocomplcache_omni_patterns')
" let g:neocomplcache_omni_patterns = {}
" endif
" let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
" "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
" let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
" let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
" let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'



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
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

"Ctr+Pで編集中のpython実行
function! s:ExecPy()
    exe "!" . &ft . " %"
        :endfunction
            command! Exec call <SID>ExecPy()
                autocmd FileType python map <silent> <C-p> :call <SID>ExecPy()<CR>


"------------------------------------
" unite.vim
"------------------------------------
"mruの保存件数
let g:unite_source_file_mru_limit = 200
"
" Uniteを開く時、垂直分割で開く
" if has("unix") 
  " let g:unite_enable_split_vertically=1
" endif

" The prefix key.
nnoremap    [unite]   <Nop>
" nmap    , [unite]
nmap    <Space> [unite]

nnoremap [unite]u  :<C-u>Unite<Space>

" nnoremap <silent> <C-u>  :<C-u>Unite -buffer-name=buffer file_mru<CR>
nnoremap <silent> <C-u>  :<C-u>Unite buffer tab file_mru directory_mru<CR>
inoremap <silent> <C-u>  <Esc>:<C-u>Unite -buffer-name=buffer tab file_mru directory_mru<CR>

" nnoremap <silent> [unite]f  :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" nnoremap <silent> <C-x><C-f>  :<C-u>UniteWithBufferDir -buffer-name=files file<CR>

nnoremap <silent> [unite]b  :<C-u>Unite -auto-preview buffer<CR>
nnoremap <silent> <C-x><C-b>  :<C-u>Unite -auto-preview buffer<CR>

nnoremap <silent> [unite]m  :<C-u>Unite file_mru<CR>

" nnoremap <silent> [unite]g  :<C-u>Unite -auto-preview grep<CR>
nnoremap <silent> [unite]g :Unite grep:%:-iHRn<CR>

" レジスタ一覧
"nnoremap <silent> <C-p> :<C-u>Unite -buffer-name=register register<CR>
"history/yankの有効化
let g:unite_source_history_yank_enable = 1
nnoremap <silent> <C-p> :<C-u>Unite history/yank<CR>
xnoremap <silent> <C-p> dh:<C-u>Unite -buffer-name=register history/yank<CR>

" 位置一覧
" nnoremap <silent> <C-p> :<C-u>Unite -auto-preview poslist<CR>

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
" MiniBufExplorer
"------------------------------------
"set minibfexp
" let g:miniBufExplMapWindowNavVim=1 "hjklで移動
" let g:miniBufExplSplitBelow=0  " Put new window above
" let g:miniBufExplMapWindowNavArrows=1
" let g:miniBufExplMapCTabSwitchBufs=1
" let g:miniBufExplModSelTarget=1
" let g:miniBufExplSplitToEdge=1
" let g:miniBufExplMaxSize = 10

":TmでMiniBufExplorerの表示トグル
" command! Mt :TMiniBufExplorer


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
let g:vimshell_prompt = '♪ '
" 右プロンプト表示
let g:vimshell_right_prompt = 'getcwd()'



"------------------------------------
" twit-vim
"------------------------------------
" let twitvim_count = 40
" nnoremap <Leader>tp :<C-u>PosttoTwitter<CR>
" nnoremap <Leader>tf :<C-u>FriendsTwitter<CR>
" nnoremap <Leader>tu :<C-u>UserTwitter<CR>
" nnoremap <Leader>tr :<C-u>RepliesTwitter<CR>
" nnoremap <Leader>td :<C-u>DMTwitter<CR>

" autocmd FileType twitvim call s:twitvim_my_settings()
" function! s:twitvim_my_settings()
  " set nowrap
" endfunction


" if has('win32')
  " let twitvim_proxy = "192.168.1.8:8080"
" endif

"------------------------------------
" kana-vim-operator-replace
"------------------------------------
nmap R <Plug>(operator-replace)


"------------------------------------
" vim-poslist
"------------------------------------
" nmap <C-o> <Plug>(poslist-prev-pos)
" nmap <C-i> <Plug>(poslist-next-pos)
nmap b <Plug>(poslist-prev-pos)
nmap B <Plug>(poslist-next-pos)


"------------------------------------
" smoothPageScroll.vim
"------------------------------------
map <C-f> :call SmoothPageScrollDown()<CR>
map <C-b> :call SmoothPageScrollUp()<CR> 
let g:smooth_page_scroll_delay = 0.5

"------------------------------------
" fugitive
"------------------------------------
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gl :Glog 
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>ga :Gwrite<CR>


"------------------------------------
" textmanip.vim
"------------------------------------
vmap <M-j> <Plug>(Textmanip.move_selection_down)
vmap <M-h> <Plug>(Textmanip.move_selection_left)
vmap <M-k> <Plug>(Textmanip.move_selection_up)
vmap <M-l> <Plug>(Textmanip.move_selection_right)
" 選択したテキストの移動
nmap <M-d> <Plug>(Textmanip.duplicate_selection_n)
vmap <M-d> <Plug>(Textmanip.duplicate_selection_v)


"------------------------------------
" open-browser.vim
"------------------------------------
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)


"------------------------------------
" VimFiler
"------------------------------------
" vimfilerをデフォルトのファイラにする
:let g:vimfiler_as_default_explorer = 1
" セーフモード無効化
:let g:vimfiler_safe_mode_by_default = 0

" nnoremap <silent> <C-x><C-j>  :VimFilerSimple<CR>
nnoremap <silent> <C-x><C-j>  :VimFiler<CR>
nnoremap <Leader>f  :VimFiler<CR>




"------------------------------------
" QfixHowm
"------------------------------------
"Howmコマンドキーマップ
let QFixHowm_Key = ' '
"Howmコマンドの2ストローク目キーマップ
let QFixHowm_KeyB = ','
"howmのファイルタイプ
let QFixHowm_FileType = 'qfix_memo'
"メニュー画面のプレビューを常に表示
let QFixHowm_MenuPreview = 1
" メニュー画面の分割方法指定  垂直分割して左側
let QFixHowm_MenuCmd = 'vertical split'
"メニュー画面の予定表示日数
let QFixHowm_ShowScheduleMenu = 15
"メニュー画面の予定・TODO表示に使われる識別子
let QFixHowm_ListReminder_MenuExt = '[-@+!~.]'
"メニュー画面で表示する最近のメモの数
let QFixHowm_MenuRecent = 25
"メニュー画面で表示するランダムメモの数
let QFixHowm_RandomWalkColumns = 15


"------------------------------------
" QfixGrep
"------------------------------------
" 検索ディレクトリはカレントディレクトリを基点にする
let MyGrep_CurrentDirMode = 0

"------------------------------------
" indent guides
"------------------------------------
" vim起動時に1だと有効
let g:indent_guides_enable_on_vim_startup = 0
" インデント強調表示の濃度
let g:indent_guides_color_change_percent = 10
" インデント強調表示の幅
let g:indent_guides_guide_size = 1
" 有効とするインデントの幅
let g:indent_guides_start_level = 2




"------------------------------------
" occur.vim
"------------------------------------
" nmap  <Leader>oc :Occur<CR>
" nmap  <Leader>mo :Moccur<CR>
" nmap  <Leader>* :StarOccur<CR>
" デフォルト定義済み



"------------------------------------
" vim-smartword
"------------------------------------
map w  <Plug>(smartword-w)
map gw  <Plug>(smartword-b)
map e  <Plug>(smartword-e)
map ge  <Plug>(smartword-ge)


"------------------------------------
" smartchr.vim
"------------------------------------
inoremap <buffer><expr> = smartchr#one_of('=', ' == ', '')
inoremap <buffer><expr> > smartchr#one_of('>', '->', '=>', '')
inoremap <buffer><expr> ( smartchr#one_of('(', '()', '')


"------------------------------------
" arpeggio.vim
"------------------------------------
"キー同時押しマッピング
call arpeggio#load()
Arpeggionmap jk <Esc>
Arpeggioimap jk <Esc>
Arpeggiocmap jk <Esc>
Arpeggiovmap jk <Esc>
Arpeggionmap fj <Esc>
Arpeggioimap fj <Esc>
Arpeggiocmap fj <Esc>
Arpeggiovmap fj <Esc>


"------------------------------------
" rainbow_parentheses.vim
"------------------------------------
" 色の指定
" let g:rbpt_colorpairs = [
    " \ ['brown',       'RoyalBlue3'],
    " \ ['Darkblue',    'SeaGreen3'],
    " \ ['darkgray',    'DarkOrchid3'],
    " \ ['darkgreen',   'firebrick3'],
    " \ ['darkcyan',    'RoyalBlue3'],
    " \ ['darkred',     'SeaGreen3'],
    " \ ['darkmagenta', 'DarkOrchid3'],
    " \ ['brown',       'firebrick3'],
    " \ ['gray',        'RoyalBlue3'],
    " \ ['black',       'SeaGreen3'],
    " \ ['darkmagenta', 'DarkOrchid3'],
    " \ ['Darkblue',    'firebrick3'],
    " \ ['darkgreen',   'RoyalBlue3'],
    " \ ['darkcyan',    'SeaGreen3'],
    " \ ['darkred',     'DarkOrchid3'],
    " \ ['red',         'firebrick3'],
    " \ ]
" 色をつける最大数
" let g:rbpt_max = 16
" 起動時にオンにする設定
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound " ()
" au Syntax * RainbowParenthesesLoadSquare "[]
" au Syntax * RainbowParenthesesLoadBraces " {}
" au Syntax * RainbowParenthesesLoadChevrons " <>



"------------------------------------
" taglist.vim
"------------------------------------
" ctags の位置を指定
if has("mac")
    " Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
endif
if has("win32")
    " Tlist_Ctags_Cmd = ""
endif

" nnoremap <silent> <leader>o :TlistToggle<CR>


"------------------------------------
" tagbar
"------------------------------------
" ctags の位置を指定
if has("mac")
	let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
endif
if has("win32")
	let g:tagbar_ctags_bin = 'C:\my\programs\vim73-kaoriya-win64-20110728\vim73-kaoriya-win64\ctags.exe'
endif

" Scala 用定義
let g:tagbar_type_scala = {
    \ 'ctagstype' : 'Scala',
    \ 'kinds'     : [
        \ 'p:packages:1',
        \ 'V:values',
        \ 'v:variables',
        \ 'T:types',
        \ 't:traits',
        \ 'o:objects',
        \ 'a:aclasses',
        \ 'c:classes',
        \ 'r:cclasses',
        \ 'm:methods'
    \ ]
\ }

nnoremap <silent> <leader>o :TagbarToggle<CR>




"------------------------------------
" TweetVim
"------------------------------------
" 発言用バッファを表示する
nnoremap <Leader>tp :TweetVimSay<CR>
" タイムライン選択用の Unite を起動する
nnoremap <Leader>tf :Unite tweetvim<CR>
" @
nnoremap <Leader>tr :TweetVimMentions<CR>
" リスト表示用
nnoremap <Leader>tl :TweetVimListStatuses 
" 検索用
nnoremap <Leader>ts :TweetVimSearch 

" スクリーン名のキャッシュを利用して、neocomplcache で補完する
if !exists('g:neocomplcache_dictionary_filetype_lists')
  let g:neocomplcache_dictionary_filetype_lists = {}
endif
let neco_dic = g:neocomplcache_dictionary_filetype_lists
let neco_dic.tweetvim_say = $HOME . '/.tweetvim/screen_name'




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
" augroup MyXML
  " autocmd!
  " autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
" augroup END


" F2で前のバッファ
map <F2> <ESC>:bp<CR>
" F3で次のバッファ
map <F3> <ESC>:bn<CR>
" F4でバッファを削除する
map <F4> <ESC>:bw<CR>

" M-bで前のバッファ
" map <M-b> <ESC>:bp<CR>
" M-nで次のバッファ
" map <M-n> <ESC>:bn<CR>
" 行の複製
" M-dでバッファを削除する
" map <M-d> <ESC>:bw<CR>

" 0, 9で行頭、行末へ
" nmap 1 0
nmap 0 ^
nnoremap 9 g$

" y9で行末までヤンク
nnoremap y9 y$
nnoremap Y y$
" y0で行頭までヤンク
nnoremap y0 y^
" v9で行末まで選択
nnoremap v9 v$h
nnoremap vv v$h


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
" map <C-e> <END>
" imap <C-e> <END>
" map <C-a> <HOME>
" imap <C-a> <HOME>

" インサートモードでもhjklで移動
imap <M-j> <Down>
imap <M-k> <Up>
imap <M-h> <Left>
imap <M-l> <Right>

" インサートモードでもundo
imap <M-u> <Esc>:undo<CR> i

" インサートモードでもdd
" imap <M-d><M-d> <Esc>dd i

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
vnoremap x "xx

" カッコ移動を楽に
" onoremap ) f)
" onoremap ( f(
" vnoremap ) f)
" vnoremap ( f(

" tabで分割移動
" nnoremap <Tab> <C-w>w

" yankした内容と単語や選択中の文字を置き換える。
" "n."で次の同じ文字も置き換える。
nnoremap <silent> cp ce<C-r>0<Esc>:let@/=@1<CR>:noh<CR>
vnoremap <silent> cp c<C-r>0<Esc>:let@/=@1<CR>:noh<CR>
nnoremap <silent> cip ciw<C-r>0<Esc>:let@/=@1<CR>:noh<CR>


" エディタのタブ操作系
nnoremap <Leader><C-T> :tabnew<CR>
nnoremap <C-Tab>   gt
nnoremap <C-S-Tab> gT

" *での検索時は次候補ではなくカーソル下結果から動かないように
nnoremap * *N

" ヤンクした文字を貼り付け
" vmap p xP

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


" メモ書き用ジャンクファイル作成
" Open junk file."{{{
command! -nargs=0 JunkFile call s:open_junk_file()
function! s:open_junk_file()
  " let l:junk_dir = $HOME . '/Desktop'. strftime('/%Y/%m')
  let l:junk_dir = $HOME . '/Desktop'. strftime('')
  if !isdirectory(l:junk_dir)
    call mkdir(l:junk_dir, 'p')
  endif

  let l:filename = input('Junk Code: ', l:junk_dir.strftime('/junk-%Y-%m-%d-%H%M%S.'))
  if l:filename != ''
    execute 'edit ' . l:filename
  endif
endfunction



"------------------------------------
" vim-toggle-wrap
"------------------------------------
" set wrapとnowrapをトグルする
function! ToggleWrap()
 if (&wrap == 1)
 set nowrap
 else
 set wrap
 set nolinebreak
 endif
endfunction

nnoremap <C-J><C-J> :call ToggleWrap()<CR>


"-------------------------------------------------------------------------------
" ファイルタイプ定義
"-------------------------------------------------------------------------------
autocmd BufNewFile,BufRead *.scala  set filetype=scala
autocmd BufNewFile,BufRead *.clj    set filetype=clojure
autocmd BufNewFile,BufRead *.ejs    set filetype=html
autocmd BufNewFile,BufRead *.rb     set filetype=ruby

autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2





"-------------------------------------------------------------------------------
" 戦闘力計測
"-------------------------------------------------------------------------------
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


