call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
Plug 'kana/vim-operator-user'

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle "kana/vim-operator-user"
NeoBundle "rhysd/vim-operator-surround"
NeoBundle "kana/vim-operator-replace"
NeoBundle "terryma/vim-expand-region"
NeoBundle "thinca/vim-quickrun"
NeoBundle "Shougo/unite.vim"
NeoBundle "Shougo/unite-sudo"
NeoBundle "Shougo/neocomplete.vim"
NeoBundle "Shougo/neomru.vim"
NeoBundle "Shougo/vimfiler"
NeoBundle "Shougo/vimshell.vim"
NeoBundle "Shougo/neossh.vim"
NeoBundle "Shougo/unite-outline"
NeoBundle "majutsushi/tagbar"
NeoBundle "kana/vim-submode"
NeoBundle "tyru/caw.vim.git"
NeoBundle "tyru/open-browser.vim"
" NeoBundle "tpope/vim-surround"
NeoBundle "tpope/vim-fugitive"
NeoBundle "tpope/vim-speeddating"
NeoBundle "joker1007/vim-markdown-quote-syntax"
NeoBundle "rcmdnk/vim-markdown"
NeoBundle "kannokanno/previm"
" NeoBundle "vim-scripts/SearchComplete"
NeoBundle "jceb/vim-orgmode"
NeoBundle "glidenote/memolist.vim"
NeoBundle "cohama/agit.vim"
NeoBundle "itchyny/lightline.vim"
NeoBundle "basyura/twibill.vim"
NeoBundle "basyura/TweetVim"
NeoBundle "jamessan/vim-gnupg"
NeoBundle "fuenor/im_control.vim"
NeoBundle "haya14busa/incsearch.vim"

" clojure
" NeoBundle "guns/vim-clojure-static"
" NeoBundle "tpope/vim-fireplace"
" NeoBundle "tpope/vim-classpath"

" lisp
" NeoBundle "kovisoft/slimv"

" haskell
" NeoBundle "dag/vim2hs"
" NeoBundle "eagletmt/neco-ghc"

" scala
" NeoBundle "derekwyatt/vim-scala"

" theme
NeoBundle "chriskempson/vim-tomorrow-theme"
NeoBundle "jonathanfilip/vim-lucius"
NeoBundle "chriskempson/base16-vim"
NeoBundle "w0ng/vim-hybrid"
NeoBundle "altercation/vim-colors-solarized"
NeoBundle "nishikawasasaki/vim-pastel-colors-theme"



call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


" キーバインド以外の設定 """"""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set clipboard=unnamedplus

" 文字コード
set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8

" カーソル位置を記憶
if has("autocmd")
  augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif

" statusline を常に表示
set laststatus=2 
" set statusline=[%l/%L]\ %r%F%m%r%h%w\%=[TYPE=%Y]\[%{&ff}:%{&fileencoding}]
set statusline=[%l/%L]\ %r%F%m%r%h%w\%=[TYPE=%Y]\[%{&ff}:%{&fileencoding}]%{fugitive#statusline()}


" 一致するところまで補完、その後は候補から選択
set wildmenu
set wildmode=list:longest,full

" 開いたバッファに応じてカレントディレクトリを変更
" nocompatible vimfiler
" set autochdir

"左右のカーソル移動で行間移動可能にする。
set whichwrap=b,s,<,>,[,],~

" vimgrep で自動的に quickfix-window を開く
autocmd QuickFixCmdPost *grep* cwindow

" 折りたたみしない
set nofoldenable

set hlsearch " 検索部分ハイライト
set incsearch "インクリメンタルサーチを行う
set ignorecase "大文字と小文字を区別しない
set smartcase "大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する

"Tab、行末の半角スペースを明示的に表示する。
set list
set listchars=tab:\ \ ,trail:\ ,

" 全角スペースを表示
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    " ZenkakuSpaceをカラーファイルで設定するなら次の行は削除
    autocmd ColorScheme       * call ZenkakuSpace()
    " 全角スペースのハイライト指定
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    autocmd VimEnter,WinEnter * match ZenkakuSpace '\%u3000'
  augroup END
  call ZenkakuSpace()
endif

" カーソル行強調
" set cursorline

" コマンドライン履歴数
set history=10000

" 分割は右へ
set splitright

" 記号がつぶれないように
set ambiwidth=double

" キーバインドの設定 """"""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = "\<Space>"

" "  ; と : を入れ替え
" nnoremap ; :
" nnoremap : ;

" 貼り付けたテキストの末尾へ自動的に移動する
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" 貼り付けたテキストを素早く選択する
noremap gV `[v`]

" インサートモードで貼り付けを簡単に
imap <C-Y> <C-R>"

" insertモードから抜ける
inoremap <silent> jj <ESC>

" Y を行末までのヤンクにする
nnoremap Y y$

" x でのヤンク避け
nnoremap x "_x

"選択した文字列を検索
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
"選択した文字列を置換
vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>
"s*でカーソル下のキーワードを置換
nnoremap <expr> s* ':%substitute/\<' . expand('<cword>') . '\>/'

"Escの2回押しでハイライト消去
nnoremap <ESC><ESC> :nohlsearch<CR>

" 行つなぎの際にスペースを入れない
nnoremap <S-j> gJ

" http://qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca
" ウインドウとタブの操作"""""""""
nnoremap s <Nop>
" 分割
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
" フォーカス移動
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sw <C-w>w " 次に移動
nnoremap so <C-w>o " ほかを閉じる
" ウインドウ自体を移動
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
" ウインドウサイズ変更
nnoremap s= <C-w>= " 均等化
call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>') " 幅を増やす
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><') " 幅を減らす
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+') " 高さを増やす
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-') " 高さ減らす
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')
" タブ操作
nnoremap st :<C-u>tabnew<CR>
nnoremap <C-Tab> gt
nnoremap <C-S-Tab> gT
" 閉じる
nnoremap sQ :<C-u>q<CR> " ウインドウを閉じる
nnoremap sq :<C-u>bd<CR> " バッファを閉じる
" バッファ移動
nnoremap L :<C-u>bn<CR>
nnoremap H :<C-u>bp<CR>


" プラグインの設定 """"""""""""""""""""""""""""""""""""""""""""""""""""

" operator 系の設定 """""""""
" surround
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)
" replace
nmap R <Plug>(operator-replace)
vmap R <Plug>(operator-replace)


" Unite
let g:unite_enable_start_insert=0
let g:unite_source_history_yank_enable =1
" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
" あいまい
call unite#filters#matcher_default#use(['matcher_fuzzy'])
" mru 件数
let g:unite_source_file_mru_limit = 200

nnoremap <silent> <Leader>uu :<C-u>Unite buffer file_mru directory_mru<CR>
nnoremap <silent> <Leader>uf :<C-u>Unite file<CR>
nnoremap <silent> <Leader>uy :<C-u>Unite history/yank<CR>
nnoremap <silent> <Leader>ug :<C-u>Unite -auto-preview grep<CR>
nnoremap <silent> <Leader>ur :<C-u>UniteResume<CR>
nnoremap <Leader>us :<C-u>Unite ssh://
nnoremap <silent> <Leader>uo :<C-u>Unite outline<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  " let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_default_opts = '--vimgrep'
  let g:unite_source_grep_recursive_opt = ''
endif

"uniteを開いている間のキーマッピング
augroup vimrc
  autocmd FileType unite call s:unite_my_settings()
augroup END
function! s:unite_my_settings()
  "ESCでuniteを終了
  nmap <buffer> <ESC> <Plug>(unite_exit)
  "入力モードのときjjでノーマルモードに移動
  imap <buffer> jj <Plug>(unite_insert_leave)
  imap <buffer> kk <Plug>(unite_insert_leave)
  "入力モードのときctrl+wでバックスラッシュも削除
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  "fでvimfiler
  nnoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
  inoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
endfunction


" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)


" neocomplete
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 1
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
" Recommended key-mappings.
" " <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function()
"   return neocomplete#close_popup() . "\<CR>"
"   " For no inserting <CR> key.
"   "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
" endfunction
" <CR>: close popup and not CR.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" caw.vim
" nmap <Leader>c <Plug>(caw:i:toggle)
nmap <Leader>c <Plug>(caw:i:toggle)<CR> " コメントアウトして次の行へ
vmap <Leader>c <Plug>(caw:i:toggle)


" vimfiler
" Use vimfiler instead of default filer.
let g:vimfiler_as_default_explorer = 1
"セーフモードを無効にした状態で起動する
let g:vimfiler_safe_mode_by_default = 0
" VimFiler ははなれたら終了する
" call vimfiler#custom#profile('default', 'context', {
			" \   'force_quit' : 1
			" \ })
"alternate file として開く
let g:vimfiler_restore_alternate_file=0
" Open filer
noremap <silent> :tree :VimFiler -split -simple -winwidth=45 -no-quit
" noremap <Leader>ff :VimFilerBufferDir -create -no-split<ENTER>
noremap <Leader>ff :VimFilerBufferDir -no-split<ENTER>
noremap <Leader>ft :VimFilerBufferDir -split -simple -winwidth=45 -no-quit<ENTER>
noremap <Leader>fs :VimFiler ssh://
" Don't let <CR> enter the directory but let it open the directory
autocmd FileType vimfiler nmap <buffer> <CR> <Plug>(vimfiler_expand_or_edit)


" vimshell
nnoremap <Leader>si :VimShellInteractive<CR>
nnoremap <Leader>ss :VimShellSendString<CR>
vmap <silent> <Leader>ss :VimShellSendString<CR>


" fugitiv
noremap <Leader>gs  :Gstatus<CR>
noremap <Leader>gg  :Gstatus<CR>
noremap <Leader>gp  :Gpush<CR>

" Agit
noremap <Leader>gl  :Agit<CR>


" vim-markdown
" 折りたたまない
let g:vim_markdown_folding_disabled=1

" memolist
let g:memolist_memo_suffix = "md"
let g:memolist_unite = 1
let g:memolist_unite_option = "-no-start-insert"
let g:memolist_prompt_tags = 1
let g:memolist_prompt_categories = 0
noremap <Leader>ml  :MemoList<CR>
noremap <Leader>mm  :MemoList<CR>
noremap <Leader>mn  :MemoNew<CR>


" lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&readonly?"x":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }
let g:lightline.tabline = {
      \ 'left': [ [ 'tabs' ] ],
      \ 'right': [ [ 'close' ] ] }
let g:lightline.tab = {
      \ 'active': [ 'tabnum', 'filename', 'modified' ],
      \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }


" tagbar
nmap <F8> :TagbarToggle<CR>



" tweetvim
" タイムライン選択用の Unite を起動する
nnoremap <silent> <Leader>tt :Unite tweetvim<CR>
" 発言用バッファを表示する
nnoremap <silent> <Leader>tn :<C-u>TweetVimSay<CR>
" mentions を表示する
" nnoremap <silent> <Space>re   :<C-u>TweetVimMentions<CR>
" 特定のリストのタイムラインを表示する
" nnoremap <silent> <Space>tt   :<C-u>TweetVimListStatuses basyura vim<CR>

" スクリーン名のキャッシュを利用して、neocomplcache で補完する
if !exists('g:neocomplcache_dictionary_filetype_lists')
  let g:neocomplcache_dictionary_filetype_lists = {}
endif
let neco_dic = g:neocomplcache_dictionary_filetype_lists
let neco_dic.tweetvim_say = $HOME . '/.tweetvim/screen_name'

" タイムラインにリツイートを含める=1
let g:tweetvim_include_rts    = 1
" アイコン表示=1 (ImageMagick が必要)
let g:tweetvim_display_icon = 0


" im_control.vim
" 「日本語入力固定モード」の動作設定
let IM_CtrlMode = 6
" 「日本語入力固定モード」切替キー
inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
" <ESC>押下後のIM切替開始までの反応が遅い場合はttimeoutlenを短く設定してみてください(ミリ秒)
set timeout timeoutlen=3000 ttimeoutlen=100


" incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)


" languages " """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" haskell
" ラムダを置き換えない
let g:haskell_conceal = 0

" lisp
let g:slimv_lisp = '/usr/bin/ccl'
let g:slimv_impl = 'clozure'
let g:slimv_preferred = 'clozure'
let g:slimv_swank_cmd = '! lilyterm -T swank -e ccl --load ~/.vim/bundle/slimv/slime/start-swank.lisp &'




" 貼り付け時にペーストバッファが上書きされないようにする
" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()


