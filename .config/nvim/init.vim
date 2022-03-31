" vim-plug """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

Plug 'Shougo/ddc.vim'
Plug 'vim-denops/denops.vim'
" Install your sources
Plug 'Shougo/ddc-around'
" Install your filters
Plug 'Shougo/ddc-matcher_head'
Plug 'Shougo/ddc-sorter_rank'
Plug 'neovim/nvim-lspconfig'
Plug 'Shougo/ddc-nvim-lsp'
Plug 'matsui54/denops-signature_help'
Plug 'matsui54/denops-popup-preview.vim'
Plug 'LumaKernel/ddc-file'
Plug 'ippachi/ddc-yank'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" brew install ripgrep
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
Plug 'thinca/vim-qfreplace'


Plug 'lambdalisue/gina.vim'

Plug 'airblade/vim-gitgutter'

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'

Plug 'itchyny/lightline.vim'

Plug 'chriskempson/base16-vim'

Plug 'nvim-lua/plenary.nvim'
" brew install coursier/formulas/coursier
" run "cs setup"
Plug 'scalameta/nvim-metals'

Plug 'fuenor/im_control.vim'


" Initialize plugin system
call plug#end()


" キーバインド以外の設定 """"""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set termguicolors
set background=dark
colorscheme base16-tomorrow-night

" 行数表示
set number

" 検索個数表示
set shortmess-=S

" Mac のクリップボードと共有
set clipboard=unnamedplus

" 開いたバッファに応じてカレントディレクトリを変更
set autochdir

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

" 一致するところまで補完、その後は候補から選択
set wildmenu
set wildmode=list:longest,full

set hlsearch " 検索部分ハイライト
set incsearch "インクリメンタルサーチを行う
set ignorecase "大文字と小文字を区別しない
set smartcase "大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する


" キーバインドの設定 """"""""""""""""""""""""""""""""""""""""""""""""""""
" Escの2回押しでハイライト消去
nnoremap <ESC><ESC> :nohlsearch<CR>
" タブ操作
nnoremap <C-Tab> gt
nnoremap <C-S-Tab> gT
" x でのヤンク避け
nnoremap x "_x

"選択した文字列を検索
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
"選択した文字列を置換
vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>
"s*でカーソル下のキーワードを置換
nnoremap <expr> s* ':%substitute/\<' . expand('<cword>') . '\>/'

" visual 時の貼り付け時にペーストバッファが上書きされないようにする
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()


" vimr """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python3_host_prog = "~/.asdf/shims/python3"
if has("gui_vimr")
  " Here goes some VimR specific settings like
  color base16-tomorrow-night
endif


" プラグインの設定 """"""""""""""""""""""""""""""""""""""""""""""""""""

" ddc.vim
call ddc#custom#patch_global('sources', ['nvim-lsp', 'yank', 'file', 'around'])
call ddc#custom#patch_global('sourceOptions', {
      \   '_': {
      \     'matchers': ['matcher_head'],
      \     'sorters': ['sorter_rank']
      \   },
      \   'around': {
      \     'mark': 'around',
      \   },
      \   'file': {
      \     'mark': 'file',
      \     'isVolatile': v:true,
      \     'forceCompletionPattern': '\S/\S*',
      \   },
      \   'yank': {
      \     'mark': 'yank',
      \   },
      \   'nvim-lsp': {
      \     'mark': 'lsp',
      \     'forceCompletionPattern': '\.\w*|:\w*|->\w*'
      \   }
      \ })
call ddc#custom#patch_global('sourceParams', {
      \ 'around': {'maxSize': 500},
      \ })

" <TAB>: completion.
inoremap <silent><expr> <TAB>
\ ddc#map#pum_visible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#map#manual_complete()
" <S-TAB>: completion back.
inoremap <expr><S-TAB>  ddc#map#pum_visible() ? '<C-p>' : '<C-h>'

" Use ddc.
call ddc#enable()

call popup_preview#enable()
call signature_help#enable()


" im_control.vim
" 「日本語入力固定モード」の動作設定
let IM_CtrlMode = 4
" 「日本語入力固定モード」切替キー
inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
" <ESC>押下後のIM切替開始までの反応が遅い場合はttimeoutlenを短く設定してみてください(ミリ秒)
set timeout timeoutlen=3000 ttimeoutlen=100


" fzf
let $FZF_PREVIEW_PREVIEW_BAT_THEME  = 'base16-256'
" nnoremap fb :Buffers<CR>
nnoremap fb :FzfPreviewBuffersRpc<CR>
nnoremap fB :FzfPreviewAllBuffersRpc<CR>
nnoremap ff :FzfPreviewDirectoryFilesRpc<CR>
nnoremap fh :FzfPreviewMruFilesRpc<CR>
nnoremap fl :FzfPreviewLinesRpc<CR>
nnoremap fs :FzfPreviewProjectGrepRpc 

nnoremap fgf :FzfPreviewGitFilesRpc<CR>
nnoremap fgs :FzfPreviewGitStatusRpc<CR>
nnoremap fgl :FzfPreviewGitLogsRpc<CR>

command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always -g "!.git/*" '.shellescape(<q-args>), 1,
\ <bang>0 ? fzf#vim#with_preview({'options': '--reverse --delimiter : --nth 3..'}, 'up:60%')
\ : fzf#vim#with_preview({'options': '--reverse --exact --delimiter : --nth 3..'}, 'right:50%', '?'),
\ <bang>0)
" 文字列検索を開く
nnoremap fg :Rg<CR>
" frでカーソル位置の単語をファイル検索する
nnoremap fr vawy:Rg <C-R>"<CR>
" frで選択した単語をファイル検索する
xnoremap fr y:Rg <C-R>"<CR>


" lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'gitbranch', 'readonly', 'filename', 'modified' ] ]
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
      \ 'component_function': {
      \   'gitbranch': 'gina#component#repo#branch'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }
" let g:lightline = {
"   \ 'colorscheme': 'wombat',
"   \ 'active': {
"   \     'left': [['mode', 'paste'],
"   \              ['gitbranch', 'readonly', 'filename', 'modified']],
"   \     'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype'],
"   \              ['cocstatus', 'currentfunction']]
"   \ },
"   \ 'component_function': {
"   \     'gitbranch': 'gina#component#repo#branch',
"   \     'mode': 'LightlineMode',
"   \     'cocstatus': 'coc#status',
"   \     'currentfunction': 'CocCurrentFunction'
"   \ }
"   \ }
let g:lightline.tabline = {
      \ 'left': [ [ 'tabs' ] ],
      \ 'right': [ [ 'close' ] ] }
let g:lightline.tab = {
      \ 'active': [ 'tabnum', 'filename', 'modified' ],
      \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }


" nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
  },
}
EOF

" fern
let g:fern#renderer = 'nerdfont'
" Ctrl+nでファイルツリーを表示/非表示する
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>
" アイコンに色をつける
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

" vim-gitgutter
" 記号の色を変更する
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
" 反映時間を短くする(デフォルトは4000ms)
set updatetime=250


" nvim-metals
set shortmess-=F
:lua << EOF
  metals_config = require'metals'.bare_config()
  metals_config.settings = {
     showImplicitArguments = true,
     excludedPackages = {
       "akka.actor.typed.javadsl",
       "com.github.swagger.akka.javadsl"
     }
  }

  metals_config.on_attach = function()
    require'completion'.on_attach();
  end

  metals_config.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = {
        prefix = '',
      }
    }
  )
EOF

if has('nvim-0.5')
  augroup lsp
    au!
    au FileType scala,sbt lua require('metals').initialize_or_attach(metals_config)
  augroup end
endif

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>

