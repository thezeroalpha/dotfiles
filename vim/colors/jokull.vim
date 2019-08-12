if version > 580
  highlight clear
  if exists("syntax_on")
    syntax reset
  endif
endif
let g:colors_name = "jokull"
set background=light
hi normal guifg=#2c2625 guibg=#e4e4e4 ctermfg=0 ctermbg=254 cterm=NONE gui=NONE
hi cursorline guifg=NONE guibg=#d0d0d0 ctermfg=NONE ctermbg=252 cterm=NONE gui=NONE
hi string guifg=#009051 guibg=NONE ctermfg=29 ctermbg=NONE cterm=italic gui=italic
hi identifier guifg=#112d4e guibg=NONE ctermfg=17 ctermbg=NONE cterm=NONE gui=NONE
hi function guifg=#0096ff guibg=NONE ctermfg=33 ctermbg=NONE cterm=bold gui=bold
hi statement guifg=#73fdff guibg=NONE ctermfg=87 ctermbg=NONE cterm=NONE gui=NONE
hi include guifg=#76d6ff guibg=NONE ctermfg=117 ctermbg=NONE cterm=bold gui=bold
hi type guifg=#005493 guibg=NONE ctermfg=24 ctermbg=NONE cterm=NONE gui=NONE
hi delimiter guifg=#fffb00 guibg=NONE ctermfg=11 ctermbg=NONE cterm=NONE gui=NONE
hi comment guifg=#ecfcff guibg=NONE ctermfg=15 ctermbg=NONE cterm=italic gui=italic
hi search guifg=NONE guibg=#d7f1e0 ctermfg=NONE ctermbg=194 cterm=NONE gui=NONE
hi folded guifg=#73fdff guibg=#d0d0d0 ctermfg=87 ctermbg=252 cterm=NONE gui=NONE
hi tablinefill guifg=NONE guibg=#d0d0d0 ctermfg=NONE ctermbg=252 cterm=NONE gui=NONE
hi tablinesel guifg=NONE guibg=#e5e5e5 ctermfg=NONE ctermbg=7 cterm=NONE gui=NONE
hi wildmenu guifg=#005493 guibg=#e5e5e5 ctermfg=24 ctermbg=7 cterm=bold gui=bold
hi linenr guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE cterm=NONE gui=NONE
hi preproc guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE cterm=NONE gui=NONE
hi vertsplit guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE cterm=NONE gui=NONE
hi todo guifg=Blue guibg=Yellow ctermfg=0 ctermbg=0 cterm=NONE gui=NONE
hi nontext guifg=#81A1C1 guibg=NONE ctermfg=109 ctermbg=NONE cterm=NONE gui=NONE
hi statusline guifg=NONE guibg=#7abecd ctermfg=NONE ctermbg=110 cterm=NONE gui=NONE
hi statuslinenc guifg=NONE guibg=#a8dbfd ctermfg=NONE ctermbg=153 cterm=NONE gui=NONE
hi visual guifg=NONE guibg=#a8caff ctermfg=NONE ctermbg=153 cterm=NONE gui=NONE
hi title guifg=#225555 guibg=NONE ctermfg=23 ctermbg=NONE cterm=bold gui=bold
hi matchparen guifg=#d7f1e0 guibg=#a8dbfd ctermfg=194 ctermbg=153 cterm=NONE gui=NONE
hi! link tabline tablinefill
hi! link incsearch search
hi! link repeat statement
hi! link conditional statement
hi! link operator statement
hi! link define include
hi! link macro include
hi! link precondit include
hi! link debug delimiter
hi! link special delimiter
hi! link specialchar delimiter
hi! link specialcomment delimiter
hi! link tag delimiter
hi! link cursorlinenr delimiter
hi! link number delimiter
hi! link label structure
hi! link storageclass structure
hi! link typedef structure
hi! link character constant
hi! link signcolumn linenr
hi! link netrwdir function
hi! link netrwexe title
hi! link spellbad todo
hi! link spellocal string
hi! link spellrare string
hi! link spellcap string
hi! link mkdlink type
hi! link vimwikilink type
hi! link pmenu statuslinenc
hi! link pmenusel statusline
