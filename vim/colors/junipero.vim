" Created with github.com/chrisbra/Colorizer and http://bytefluent.com/vivify/
set background=dark
if version > 580
  highlight clear
  if exists("syntax_on")
    syntax reset
  endif
endif

" Utility function: github.com/Jorengarenar/vim-colors-B_W
function! s:h(group, style)
    execute "highlight" a:group
                \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
                \ "ctermbg=" (has_key(a:style, "bg")    ? a:style.bg.cterm : "NONE")
                \ "ctermfg=" (has_key(a:style, "fg")    ? a:style.fg.cterm : "NONE")
                \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
                \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
                \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
                \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
endfunction

let g:colors_name = "junipero"

let s:text_color = {"gui": "#969696", "cterm": "246"}
let s:bg_color = {"gui": "#11121A", "cterm": "0"}
call s:h("Normal", {"fg": s:text_color, "bg": s:bg_color})
call s:h("CursorLine", {"bg": {"gui":"#222222", "cterm": "0"}})

" Code - constants
hi Structure guifg=#0490e8 guibg=NONE guisp=NONE gui=bold ctermfg=32 ctermbg=NONE cterm=bold
hi Constant guifg=#5c78f0 guibg=NONE guisp=NONE gui=NONE ctermfg=69 ctermbg=NONE cterm=NONE
hi String guifg=#2de3e6 guibg=NONE guisp=NONE gui=NONE ctermfg=44 ctermbg=NONE cterm=NONE
hi Float guifg=#4580b4 guibg=NONE guisp=NONE gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi Boolean guifg=#fca8ad guibg=NONE guisp=NONE gui=NONE ctermfg=217 ctermbg=NONE cterm=NONE
hi! link Label Structure
hi! link StorageClass Structure
hi! link Typedef Structure
hi! link Character Constant

" Code - identifiers/variables
hi Identifier guifg=#5094c4 guibg=NONE guisp=NONE gui=NONE ctermfg=74 ctermbg=NONE cterm=NONE
hi Function guifg=#f9c60e guibg=#11121a guisp=#11121a gui=bold ctermfg=220 ctermbg=234 cterm=bold

" Code - statements
hi Number guifg=#136aed guibg=NONE guisp=NONE gui=NONE ctermfg=27 ctermbg=NONE cterm=NONE
hi Conditional guifg=#d0688d guibg=#11121a guisp=#11121a gui=NONE ctermfg=168 ctermbg=234 cterm=NONE
hi Operator guifg=#e8cdc0 guibg=#11121a guisp=#11121a gui=NONE ctermfg=181 ctermbg=234 cterm=NONE
hi Exception guifg=#d0a8ad guibg=#11121a guisp=#11121a gui=bold ctermfg=181 ctermbg=234 cterm=bold
hi Statement guifg=#ff6c11 guibg=NONE guisp=NONE gui=NONE ctermfg=202 ctermbg=NONE cterm=NONE
hi Repeat guifg=#e06070 guibg=#11121a guisp=#11121a gui=NONE ctermfg=167 ctermbg=234 cterm=NONE
hi Keyword guifg=#bebebe guibg=#11121a guisp=#11121a gui=bold ctermfg=7 ctermbg=234 cterm=bold

" Code - preprocessors
hi PreProc guifg=#ae15eb guibg=NONE guisp=NONE gui=NONE ctermfg=129 ctermbg=NONE cterm=NONE
hi Include guifg=#ba75cf guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi! link Define Include
hi! link Macro Include
hi! link PreCondit Include

" Code - types
hi Type guifg=#ff3863 guibg=NONE guisp=NONE gui=bold ctermfg=13 ctermbg=NONE cterm=bold

" Code - special
hi Delimiter guifg=#aaaaca guibg=NONE guisp=NONE gui=NONE ctermfg=146 ctermbg=NONE cterm=NONE
hi Comment guifg=#349d58 guibg=#11121a guisp=#11121a gui=NONE ctermfg=72 ctermbg=234 cterm=NONE
hi NonText guifg=#382920 guibg=#11121a guisp=#11121a gui=NONE ctermfg=237 ctermbg=234 cterm=NONE
hi Ignore guifg=#666666 guibg=NONE guisp=NONE gui=NONE ctermfg=241 ctermbg=NONE cterm=NONE
hi SpecialKey guifg=#90dcb0 guibg=NONE guisp=NONE gui=NONE ctermfg=115 ctermbg=NONE cterm=NONE
hi Underlined guifg=#bac5ba guibg=NONE guisp=NONE gui=NONE ctermfg=151 ctermbg=NONE cterm=NONE
hi Error guifg=NONE guibg=#b03452 guisp=#b03452 gui=NONE ctermfg=NONE ctermbg=131 cterm=NONE
hi Todo guifg=#ffd500 guibg=#5c0d43 guisp=#5c0d43 gui=NONE ctermfg=220 ctermbg=53 cterm=NONE
hi! link Debug Delimiter
hi! link Special Delimiter
hi! link SpecialChar Delimiter
hi! link SpecialComment Delimiter
hi! link Tag Delimiter

" Misc mode specific
hi MatchParen guifg=#001122 guibg=#7b5a55 guisp=#7b5a55 gui=NONE ctermfg=17 ctermbg=95 cterm=NONE
hi Cursor guifg=#0000aa guibg=#cad5c0 guisp=#cad5c0 gui=NONE ctermfg=19 ctermbg=151 cterm=NONE
hi Visual guifg=#102030 guibg=#80a0f0 guisp=#80a0f0 gui=NONE ctermfg=17 ctermbg=111 cterm=NONE
hi VisualNOS guifg=#201a30 guibg=#a3a5FF guisp=#a3a5FF gui=NONE ctermfg=236 ctermbg=147 cterm=NONE

" GUI
hi LineNr guifg=#2069a9 guibg=#101124 guisp=#101124 gui=NONE ctermfg=25 ctermbg=235 cterm=NONE
hi Search guifg=#2de3e6 guibg=#6b5469 guisp=#6b5469 gui=NONE ctermfg=44 ctermbg=242 cterm=NONE
hi IncSearch guifg=#babeaa guibg=#3a4520 guisp=#3a4520 gui=NONE ctermfg=144 ctermbg=58 cterm=NONE
hi WildMenu guifg=#000000 guibg=#804000 guisp=#804000 gui=NONE ctermfg=NONE ctermbg=3 cterm=NONE
hi VertSplit guifg=#223355 guibg=#22253c guisp=#22253c gui=NONE ctermfg=17 ctermbg=237 cterm=NONE
hi TabLineSel guifg=#6079c9 guibg=#363649 guisp=#101124 gui=NONE ctermfg=24 ctermbg=59 cterm=NONE
hi Title guifg=#fff7fa guibg=NONE guisp=NONE gui=NONE ctermfg=15 ctermbg=NONE cterm=NONE
hi PmenuSel guifg=#f0e0b2 guibg=#4a85ba guisp=#4a85ba gui=NONE ctermfg=223 ctermbg=67 cterm=NONE
hi PmenuThumb guifg=NONE guibg=#000000 guisp=#000000 gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi PmenuSbar guifg=NONE guibg=#0000ff guisp=#0000ff gui=NONE ctermfg=NONE ctermbg=21 cterm=NONE
hi Pmenu guifg=#bdbdbd guibg=#915623 guisp=#915623 gui=NONE ctermfg=250 ctermbg=94 cterm=NONE
hi Folded guifg=#bebebe guibg=#232235 guisp=#232235 gui=NONE ctermfg=7 ctermbg=236 cterm=NONE
hi FoldColumn guifg=#dbcaa5 guibg=#0a0a18 guisp=#0a0a18 gui=NONE ctermfg=187 ctermbg=234 cterm=NONE
hi Directory guifg=#bbd0df guibg=NONE guisp=NONE gui=NONE ctermfg=152 ctermbg=NONE cterm=NONE
hi! link StatusLine LineNr
hi! link StatusLineNC LineNR
hi! link TabLine LineNR
hi! link TabLineFill LineNR
hi! link SignColumn LineNR

" Diff
hi DiffDelete guifg=#300845 guibg=#200845 guisp=#200845 gui=NONE ctermfg=53 ctermbg=17 cterm=NONE
hi DiffText guifg=#f5f5f5 guibg=#423f00 guisp=#423f00 gui=NONE ctermfg=255 ctermbg=58 cterm=NONE
hi DiffAdd guifg=#e0e3e3 guibg=#003802 guisp=#003802 gui=NONE ctermfg=254 ctermbg=22 cterm=NONE
hi DiffChange guifg=#fcfcfc guibg=#2e032e guisp=#2e032e gui=NONE ctermfg=15 ctermbg=53 cterm=NONE

" Messages
hi ModeMsg guifg=#00AACC guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi Question guifg=#AABBCC guibg=#130445 guisp=#130445 gui=NONE ctermfg=146 ctermbg=17 cterm=NONE
hi MoreMsg guifg=#2e8b57 guibg=NONE guisp=NONE gui=NONE ctermfg=29 ctermbg=NONE cterm=NONE
hi ErrorMsg guifg=#f0e2e2 guibg=#ff4545 guisp=#ff4545 gui=NONE ctermfg=255 ctermbg=203 cterm=NONE
hi WarningMsg guifg=#fa8072 guibg=NONE guisp=NONE gui=NONE ctermfg=210 ctermbg=NONE cterm=NONE

" Netrw
hi! link netrwDir LineNr
hi! link netrwExe Title
hi! link SpellBad  Todo
hi! link SpelLocal String
hi! link SpellRare String
hi! link SpellCap String

" Vimwiki
hi! link VimwikiLink Constant
