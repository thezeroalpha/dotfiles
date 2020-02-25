" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Clear the syntax
syntax clear

" Define highlighting groups
syntax keyword vimcolorKeyword background light dark
syntax keyword vimcolorNone NONE
syntax keyword vimcolorAttrs italic bold
syntax match vimcolorGroup "^[A-Z][^ ]*"
syntax match vimcolorName "[ ,]\zs[^# ][^ ]*"
syntax match vimcolorColor "#[0-9a-fA-F]\+"
syntax match vimcolorDelims "[,.]" containedin=vimcolorLinkSource
syntax match vimcolorLinkLine "^link .*$" contains=vimcolorLink,vimcolorLinkSource,vimcolorLinkDest
syntax keyword vimcolorLink contained link
syntax match vimcolorLinkSource "\(link \)\@<=[a-zA-Z,]\+" contained
syntax match vimcolorLinkDest "[a-zA-Z]\+$" contained
syntax region vimcolorComment start=/^ *"/ end="$"
syntax region vimcolorPalette start="^palette:" end="\." contains=vimcolorPaletteKeyword,vimcolorPaletteColorName,vimcolorPaletteColorVal,vimcolorComment
syntax match vimcolorPaletteColorName "^ *\zs[^ ]\+" contained
syntax match vimcolorPaletteColorVal "#[a-fA-F0-9]\+" contained
syntax keyword vimcolorPaletteKeyword palette contained

" Perform the actual highlighting
hi def link vimcolorKeyword Include
hi def link vimcolorGroup Statement
hi def link vimcolorLinkSource Statement
hi def link vimcolorColor Constant
hi def link vimcolorNone Include
hi def link vimcolorDelims Delimiter
hi def link vimcolorAttrs String
hi def link vimcolorLink Operator
hi def link vimcolorLinkDest Identifier
hi def link vimcolorComment Comment
hi def link vimcolorPaletteColorName Number
hi def link vimcolorPaletteColorVal Constant
hi def link vimcolorPaletteKeyword Include
hi def link vimcolorName Number

let b:current_syntax = "vimcolor"
let &cpo = s:cpo_save
unlet s:cpo_save
