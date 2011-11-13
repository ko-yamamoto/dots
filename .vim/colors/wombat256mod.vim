" Vim color file
" Original Maintainer:  Lars H. Nielsen (dengmao@gmail.com)
" Last Change:  2010-07-23
"
" Modified version of wombat for 256-color terminals by
"   David Liang (bmdavll@gmail.com)
" based on version by
"   Danila Bespalov (danila.bespalov@gmail.com)

set background=dark

if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

let colors_name = "wombat256mod"


" General colors
hi Normal		ctermfg=252	cterm=none		guifg=#e3e0d7	gui=none
hi Cursor		ctermfg=234				cterm=none		guifg=#242424		gui=none
hi Visual		ctermfg=251				cterm=none		guifg=#c3c6ca		gui=none
hi VisualNOS	ctermfg=251				cterm=none		guifg=#c3c6ca		gui=none
hi Search		ctermfg=177				cterm=none		guifg=#d787ff		gui=none
hi Folded		ctermfg=103				cterm=none		guifg=#a0a8b0		gui=none
hi Title		ctermfg=230						cterm=bold		guifg=#ffffd7					gui=bold
hi StatusLine	ctermfg=230				cterm=none		guifg=#ffffd7		gui=italic
hi VertSplit	ctermfg=238				cterm=none		guifg=#444444		gui=none
hi StatusLineNC	ctermfg=241				cterm=none		guifg=#857b6f		gui=none
hi LineNr		ctermfg=241				cterm=none		guifg=#857b6f		gui=none
hi SpecialKey	ctermfg=241				cterm=none		guifg=#626262		gui=none
hi WarningMsg	ctermfg=203										guifg=#ff5f55
hi ErrorMsg		ctermfg=196				cterm=bold		guifg=#ff2026		gui=bold

" Vim >= 7.0 specific colors
if version >= 700
hi CursorLine							cterm=none						
hi MatchParen	ctermfg=228				cterm=bold		guifg=#eae788		gui=bold
hi Pmenu		ctermfg=230								guifg=#ffffd7	
hi PmenuSel		ctermfg=232								guifg=#080808	
endif

" Diff highlighting
" hi DiffAdd															
hi DiffDelete	ctermfg=234			cterm=none		guifg=#242424		gui=none
hi DiffText							cterm=none							gui=none
" hi DiffChange															

"hi CursorIM
"hi Directory
"hi IncSearch
"hi Menu
"hi ModeMsg
"hi MoreMsg
"hi PmenuSbar
"hi PmenuThumb
"hi Question
"hi Scrollbar
"hi SignColumn
"hi SpellBad
"hi SpellCap
"hi SpellLocal
"hi SpellRare
"hi TabLine
"hi TabLineFill
"hi TabLineSel
"hi Tooltip
"hi User1
"hi User9
"hi WildMenu


" Syntax highlighting
hi Keyword		ctermfg=111		cterm=none		guifg=#88b8f6	gui=none
hi Statement	ctermfg=111		cterm=none		guifg=#88b8f6	gui=none
hi Constant		ctermfg=173		cterm=none		guifg=#e5786d	gui=none
hi Number		ctermfg=173		cterm=none		guifg=#e5786d	gui=none
hi PreProc		ctermfg=173		cterm=none		guifg=#e5786d	gui=none
hi Function		ctermfg=192		cterm=none		guifg=#cae982	gui=none
hi Identifier	ctermfg=192		cterm=none		guifg=#cae982	gui=none
hi Type			ctermfg=186		cterm=none		guifg=#d4d987	gui=none
hi Special		ctermfg=229		cterm=none		guifg=#eadead	gui=none
hi String		ctermfg=113		cterm=none		guifg=#95e454	gui=italic
hi Comment		ctermfg=246		cterm=none		guifg=#9c998e	gui=italic
hi Todo			ctermfg=101		cterm=none		guifg=#857b6f	gui=italic


" Links
hi! link FoldColumn		Folded
hi! link CursorColumn	CursorLine
hi! link NonText		LineNr

" vim:set ts=4 sw=4 noet:
