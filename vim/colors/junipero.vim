if version > 580
  highlight clear
  if exists("syntax_on")
    syntax reset
  endif
endif
let g:colors_name = "junipero"
set background=dark
hi normal guifg=#969696 guibg=#11121A ctermfg=246 ctermbg=0 cterm=NONE gui=NONE
hi cursorline guifg=NONE guibg=#222222 ctermfg=NONE ctermbg=234 cterm=NONE gui=NONE
hi Structure guifg=#0490e8 guibg=NONE ctermfg=32 ctermbg=NONE cterm=bold gui=bold
hi Constant guifg=#5c78f0 guibg=NONE ctermfg=69 ctermbg=NONE cterm=NONE gui=NONE
hi String guifg=#2de3e6 guibg=NONE ctermfg=6 ctermbg=NONE cterm=NONE gui=NONE
hi Float guifg=#4580b4 guibg=NONE ctermfg=67 ctermbg=NONE cterm=NONE gui=NONE
hi Boolean guifg=#fca8ad guibg=NONE ctermfg=217 ctermbg=NONE cterm=NONE gui=NONE
hi Identifier guifg=#5094c4 guibg=NONE ctermfg=68 ctermbg=NONE cterm=NONE gui=NONE
hi Function guifg=#f9c60e guibg=#11121a ctermfg=220 ctermbg=0 cterm=bold gui=bold
hi Number guifg=#136aed guibg=NONE ctermfg=27 ctermbg=NONE cterm=NONE gui=NONE
hi Conditional guifg=#d0688d guibg=#11121a ctermfg=168 ctermbg=0 cterm=NONE gui=NONE
hi Operator guifg=#e8cdc0 guibg=#11121a ctermfg=187 ctermbg=0 cterm=NONE gui=NONE
hi Exception guifg=#d0a8ad guibg=#11121a ctermfg=181 ctermbg=0 cterm=bold gui=bold
hi Statement guifg=#ff6c11 guibg=NONE ctermfg=202 ctermbg=NONE cterm=NONE gui=NONE
hi Repeat guifg=#e06070 guibg=#11121a ctermfg=167 ctermbg=0 cterm=NONE gui=NONE
hi Keyword guifg=#bebebe guibg=#11121a ctermfg=250 ctermbg=0 cterm=bold gui=bold
hi PreProc guifg=#ae15eb guibg=NONE ctermfg=5 ctermbg=NONE cterm=NONE gui=NONE
hi Include guifg=#ba75cf guibg=NONE ctermfg=140 ctermbg=NONE cterm=NONE gui=NONE
hi Type guifg=#ff3863 guibg=NONE ctermfg=203 ctermbg=NONE cterm=bold gui=bold
hi Delimiter guifg=#aaaaca guibg=NONE ctermfg=146 ctermbg=NONE cterm=NONE gui=NONE
hi Comment guifg=#349d58 guibg=#11121a ctermfg=71 ctermbg=0 cterm=NONE gui=NONE
hi NonText guifg=#382920 guibg=#11121a ctermfg=1 ctermbg=0 cterm=NONE gui=NONE
hi Ignore guifg=#666666 guibg=NONE ctermfg=241 ctermbg=NONE cterm=NONE gui=NONE
hi SpecialKey guifg=#90dcb0 guibg=NONE ctermfg=115 ctermbg=NONE cterm=NONE gui=NONE
hi Underlined guifg=#bac5ba guibg=NONE ctermfg=151 ctermbg=NONE cterm=NONE gui=NONE
hi Error guifg=NONE guibg=#b03452 ctermfg=NONE ctermbg=131 cterm=NONE gui=NONE
hi Todo guifg=#ffd500 guibg=#5c0d43 ctermfg=220 ctermbg=53 cterm=NONE gui=NONE
hi MatchParen guifg=#001122 guibg=#7b5a55 ctermfg=0 ctermbg=95 cterm=NONE gui=NONE
hi Cursor guifg=#0000aa guibg=#cad5c0 ctermfg=19 ctermbg=187 cterm=NONE gui=NONE
hi Visual guifg=#102030 guibg=#80a0f0 ctermfg=17 ctermbg=111 cterm=NONE gui=NONE
hi VisualNOS guifg=#201a30 guibg=#a3a5FF ctermfg=17 ctermbg=147 cterm=NONE gui=NONE
hi LineNr guifg=#2069a9 guibg=#101124 ctermfg=25 ctermbg=0 cterm=NONE gui=NONE
hi Search guifg=#2de3e6 guibg=#6b5469 ctermfg=6 ctermbg=59 cterm=NONE gui=NONE
hi IncSearch guifg=#babeaa guibg=#3a4520 ctermfg=145 ctermbg=58 cterm=NONE gui=NONE
hi WildMenu guifg=#000000 guibg=#804000 ctermfg=0 ctermbg=94 cterm=NONE gui=NONE
hi VertSplit guifg=#223355 guibg=#22253c ctermfg=23 ctermbg=17 cterm=NONE gui=NONE
hi TabLineSel guifg=#6079c9 guibg=#363649 ctermfg=68 ctermbg=59 cterm=NONE gui=NONE
hi Title guifg=#fff7fa guibg=NONE ctermfg=15 ctermbg=NONE cterm=NONE gui=NONE
hi PmenuSel guifg=#f0e0b2 guibg=#4a85ba ctermfg=223 ctermbg=67 cterm=NONE gui=NONE
hi PmenuThumb guifg=NONE guibg=#000000 ctermfg=NONE ctermbg=0 cterm=NONE gui=NONE
hi PmenuSbar guifg=NONE guibg=#0000ff ctermfg=NONE ctermbg=21 cterm=NONE gui=NONE
hi Pmenu guifg=#bdbdbd guibg=#915623 ctermfg=250 ctermbg=94 cterm=NONE gui=NONE
hi Folded guifg=#bebebe guibg=#232235 ctermfg=250 ctermbg=17 cterm=NONE gui=NONE
hi FoldColumn guifg=#dbcaa5 guibg=#0a0a18 ctermfg=187 ctermbg=0 cterm=NONE gui=NONE
hi Directory guifg=#bbd0df guibg=NONE ctermfg=152 ctermbg=NONE cterm=NONE gui=NONE
hi DiffDelete guifg=#300845 guibg=#200845 ctermfg=53 ctermbg=17 cterm=NONE gui=NONE
hi DiffText guifg=#f5f5f5 guibg=#423f00 ctermfg=15 ctermbg=58 cterm=NONE gui=NONE
hi DiffAdd guifg=#e0e3e3 guibg=#003802 ctermfg=188 ctermbg=22 cterm=NONE gui=NONE
hi DiffChange guifg=#fcfcfc guibg=#2e032e ctermfg=15 ctermbg=0 cterm=NONE gui=NONE
hi ModeMsg guifg=#00AACC guibg=NONE ctermfg=38 ctermbg=NONE cterm=NONE gui=NONE
hi Question guifg=#AABBCC guibg=#130445 ctermfg=146 ctermbg=17 cterm=NONE gui=NONE
hi MoreMsg guifg=#2e8b57 guibg=NONE ctermfg=29 ctermbg=NONE cterm=NONE gui=NONE
hi ErrorMsg guifg=#f0e2e2 guibg=#ff4545 ctermfg=224 ctermbg=203 cterm=NONE gui=NONE
hi WarningMsg guifg=#fa8072 guibg=NONE ctermfg=209 ctermbg=NONE cterm=NONE gui=NONE
hi StatusLine guifg=#4079a9 guibg=#101130 ctermfg=67 ctermbg=17 cterm=bold gui=bold
hi! link Label Structure
hi! link StorageClass Structure
hi! link Typedef Structure
hi! link Character Constant
hi! link VimwikiLink Constant
hi! link Define Include
hi! link Macro Include
hi! link PreCondit Include
hi! link Debug Delimiter
hi! link Special Delimiter
hi! link SpecialChar Delimiter
hi! link SpecialComment Delimiter
hi! link Tag Delimiter
hi! link StatusLineNC LineNr
hi! link TabLine LineNr
hi! link TabLineFill LineNr
hi! link SignColumn LineNr
hi! link netrwDir LineNr
hi! link netrwExe Title
hi! link SpellBad Todo
hi! link SpelLocal String
hi! link SpellRare String
hi! link SpellCap String
hi! link mkdLink Type
