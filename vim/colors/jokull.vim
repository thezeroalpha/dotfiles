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
hi statement guifg=#0050a0 guibg=NONE ctermfg=25 ctermbg=NONE cterm=NONE gui=NONE
hi include guifg=#2696bf guibg=NONE ctermfg=31 ctermbg=NONE cterm=bold gui=bold
hi type guifg=#005493 guibg=NONE ctermfg=24 ctermbg=NONE cterm=NONE gui=NONE
hi search guifg=NONE guibg=#d7f1e0 ctermfg=NONE ctermbg=194 cterm=NONE gui=NONE
hi folded guifg=#236dff guibg=#d0d0d0 ctermfg=27 ctermbg=252 cterm=NONE gui=NONE
hi tablinefill guifg=NONE guibg=#d0d0d0 ctermfg=NONE ctermbg=252 cterm=NONE gui=NONE
hi tablinesel guifg=NONE guibg=#e5e5e5 ctermfg=NONE ctermbg=7 cterm=NONE gui=NONE
hi wildmenu guifg=#005493 guibg=#e5e5e5 ctermfg=24 ctermbg=7 cterm=bold gui=bold
hi linenr guifg=#9b9b4c guibg=NONE ctermfg=101 ctermbg=NONE cterm=NONE gui=NONE
hi preproc guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE cterm=NONE gui=NONE
hi vertsplit guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE cterm=NONE gui=NONE
hi todo guifg=Blue guibg=Yellow ctermfg=0 ctermbg=0 cterm=NONE gui=NONE
hi nontext guifg=#81A1C1 guibg=NONE ctermfg=109 ctermbg=NONE cterm=NONE gui=NONE
hi statusline guifg=NONE guibg=#7abecd ctermfg=NONE ctermbg=110 cterm=NONE gui=NONE
hi statuslinenc guifg=NONE guibg=#a8dbfd ctermfg=NONE ctermbg=153 cterm=NONE gui=NONE
hi visual guifg=NONE guibg=#a8caff ctermfg=NONE ctermbg=153 cterm=NONE gui=NONE
hi title guifg=#225555 guibg=NONE ctermfg=23 ctermbg=NONE cterm=bold gui=bold
hi matchparen guifg=#d7f1e0 guibg=#a8dbfd ctermfg=194 ctermbg=153 cterm=NONE gui=NONE
hi qfFileName guifg=#0076ff guibg=NONE ctermfg=33 ctermbg=NONE cterm=NONE gui=NONE
hi delimiter guifg=#5f5f00 guibg=NONE ctermfg=58 ctermbg=NONE cterm=NONE gui=NONE
hi comment guifg=#5f5f5f guibg=NONE ctermfg=59 ctermbg=NONE cterm=italic gui=italic
hi diffadd guifg=NONE guibg=#a5ffa5 ctermfg=NONE ctermbg=157 cterm=NONE gui=NONE
hi diffdelete guifg=NONE guibg=#ffa5a5 ctermfg=NONE ctermbg=217 cterm=NONE gui=NONE
hi diffchange guifg=#a9dbff guibg=#c0beff ctermfg=153 ctermbg=147 cterm=NONE gui=NONE
hi difftext guifg=NONE guibg=#a0aeff ctermfg=NONE ctermbg=147 cterm=NONE gui=NONE
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
hi! link markdownUrl string
hi! link mkdlink type
hi! link vimwikilink type
hi! link pmenu statuslinenc
hi! link pmenusel statusline
