" NeoBundle """"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

" unite """"""""""""""""""""""""""
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/neomru.vim'

" utils """"""""""""""""""""""""""
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neossh.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'ujihisa/vimshell-ssh'

NeoBundle 'kana/vim-submode'

NeoBundle 'tyru/caw.vim'

" git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'

" lang """""""""""""""""""""""
" markdown
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
" scala
NeoBundle 'derekwyatt/vim-scala'


" color scheme
NeoBundle 'w0ng/vim-hybrid'


call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


" .vimrc 編集で自動再読み込み """"""""""""""""""""""""""""""""""""""
" set script encoding
scriptencoding utf-8
" syntax hilight
syntax enable
" auto reload .vimrc
augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END




" 動作・挙動設定 """"""""""""""""""""""""""""""""""""""""""""""
" statusline を常に表示
set laststatus=2 
set statusline=[%l/%L]%Y\ %r%F%m%r%h%w\%=\[%{&ff}:%{&fileencoding}]%{fugitive#statusline()}

" クリップボードを OS と共有
set clipboard=unnamedplus,autoselect

" 終了時のカーソル位置を記憶
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

"タブ入力を複数の空白入力に置き換える
" set expandtab 
"画面上でタブ文字が占める幅
set tabstop=4 
"自動インデントでずれる幅
set shiftwidth=4 
"連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=2 
"改行時に前の行のインデントを継続する
set autoindent 
"改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent 



" キーバインディング設定 """"""""""""""""""""""""""""""""""""""""""""""
" OS からの貼り付け
nnoremap <C-y> "+p
nnoremap <C-Y> "+P

" insertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> hh <ESC>

" *での検索時は次候補ではなくカーソル下結果から動かないように
nnoremap * *N

" ハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>

" ウィンドウをひとつに
nnoremap <Esc><Esc><Esc> :only<CR>

" 選択した文字列を検索
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" 選択した文字列を置換
vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>

" カーソル下のキーワードを置換
nnoremap <expr> sr ':%substitute/\<' . expand('<cword>') . '\>//gc<Left><Left><Left>'


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



" プラグイン設定 """"""""""""""""""""""""""""""""""""""""""""""
" キーマップリーダー
let mapleader = " "

" unite.vim
"------------------------------------
"mruの保存件数
let g:unite_source_file_mru_limit = 200
" Follow symlinks
let g:unite_source_find_default_opts = "-L"

"uniteを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
	"ESCでuniteを終了
	nmap <buffer> <ESC> <Plug>(unite_exit)
	"入力モードのときjjでノーマルモードに移動
	imap <buffer> jj <Plug>(unite_insert_leave)
	"入力モードのときctrl+wでバックスラッシュも削除
	imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
	"ctrl+jで縦に分割して開く
	nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
	inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
	"ctrl+jで横に分割して開く
	nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
	inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
	"ctrl+oでその場所に開く
	nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
	inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
endfunction"}}}

nnoremap    [unite]   <Nop>
nmap    <Space> [unite]

nnoremap <silent> [unite];   :<C-u>Unite buffer tab file_mru directory_mru<CR>



" vimfiler.vim
"------------------------------------
" vimfiler をデフォルトのファイラに
:let g:vimfiler_as_default_explorer = 1
" 開いているファイルのディレクトリに移動
let g:vimfiler_enable_auto_cd = 1

nnoremap <leader>xj  :VimFilerBufferDir<CR>
nnoremap <leader>xJ  :VimFiler<CR>
" nnoremap <leader>XJ  :VimFilerTab<CR>



" neocomplte.vim
"------------------------------------
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
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><C-y>  neocomplete#close_popup()
" inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
" inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"


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
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
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



" vim-fugitive and gitv
"------------------------------------
nnoremap    [git]   <Nop>
nmap    <Space>g [git]

nnoremap <silent> [git]s :Gstatus<CR>
nnoremap <silent> [git]a :Gwrite<CR>
nnoremap <silent> [git]P :Gpush<CR>
nnoremap <silent> [git]p :Gpull<CR>
nnoremap <silent> [git]f :Gfetch<CR>

nnoremap <silent> [git]l :Gitv<CR>
nnoremap <silent> [git]L :Gitv!<CR>


" tyru/caw.vim
"------------------------------------
nmap <Leader>cc <Plug>(caw:i:toggle)
vmap <Leader>cc <Plug>(caw:i:toggle)




" plasticboy/vim-markdown
"------------------------------------
" .md を markdown として開く
au BufRead,BufNewFile *.md set filetype=markdown
" 折りたたみを行なう階層の深さ
let g:vim_markdown_initial_foldlevel=3
" デフォルトのキーバインドを無効に
let g:vim_markdown_no_default_key_mappings=1
" ブラウザで開く
nnoremap <leader>bo :PrevimOpen<CR>




