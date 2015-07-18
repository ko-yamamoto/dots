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
NeoBundle "terryma/vim-expand-region"
NeoBundle "Shougo/unite.vim"
NeoBundle "Shougo/unite-sudo"
NeoBundle "Shougo/neocomplete.vim"
NeoBundle "Shougo/neomru.vim"
NeoBundle "Shougo/vimfiler"
NeoBundle "Shougo/vimshell.vim"
NeoBundle "Shougo/neossh.vim"
NeoBundle "kana/vim-submode"
NeoBundle "tyru/caw.vim.git"
NeoBundle "tyru/open-browser.vim"
NeoBundle "tpope/vim-surround"
NeoBundle "tpope/vim-fugitive"
NeoBundle "plasticboy/vim-markdown"
NeoBundle "kannokanno/previm"
NeoBundle "vim-scripts/SearchComplete"
NeoBundle "chriskempson/base16-vim"
NeoBundle "jceb/vim-orgmode"
NeoBundle "glidenote/memolist.vim"
NeoBundle "cohama/agit.vim"
NeoBundle "itchyny/lightline.vim"

" clojure
NeoBundle "guns/vim-clojure-static"
NeoBundle "tpope/vim-fireplace"
NeoBundle "tpope/vim-classpath"

" theme
NeoBundle "chriskempson/vim-tomorrow-theme"
NeoBundle "jonathanfilip/vim-lucius"
NeoBundle "w0ng/vim-hybrid"


call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


" キーバインド以外の設定 """"""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set clipboard=unnamedplus


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

" キーバインドの設定 """"""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = "\<Space>"

" 貼り付けたテキストの末尾へ自動的に移動する
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" 貼り付けたテキストを素早く選択する
noremap gV `[v`]

" insertモードから抜ける
inoremap <silent> jj <ESC>

" Y を行末までのヤンクにする
nnoremap Y y$

" x でのヤンク避け
nnoremap x "_x



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
nnoremap sq :<C-u>q<CR> " ウインドウを閉じる
nnoremap sQ :<C-u>bd<CR> " バッファを閉じる
" バッファ移動
nnoremap L :<C-u>bn<CR>
nnoremap H :<C-u>bp<CR>



" プラグインの設定 """"""""""""""""""""""""""""""""""""""""""""""""""""

" Unite
let g:unite_enable_start_insert=0
let g:unite_source_history_yank_enable =1
" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
" mru 件数
let g:unite_source_file_mru_limit = 200

nnoremap <silent> <Leader>uu :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> <Leader>uy :<C-u>Unite history/yank<CR>
nnoremap <silent> <Leader>ug :<C-u>Unite grep<CR>
nnoremap <silent> <Leader>ur :<C-u>UniteResume<CR>
nnoremap <silent> <Leader>us :<C-u>Unite ssh://

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " Overwrite settings.
  imap <buffer> jj <Plug>(unite_insert_leave)
  imap <buffer> <ESC> <ESC><ESC>
  nnoremap <buffer> t G
  startinsert
endfunction

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif


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
let g:neocomplete#sources#syntax#min_keyword_length = 3
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
" Open filer
noremap <silent> :tree :VimFiler -split -simple -winwidth=45 -no-quit
noremap <Leader>ff :VimFilerBufferDir -no-split<ENTER>
noremap <Leader>ft :VimFilerBufferDir -split -simple -winwidth=45 -no-quit<ENTER>
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
let g:memolist_unite_option = "-auto-preview -start-insert"
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


