" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Clear the syntax
syntax clear

" Define highlighting groups
syntax keyword vimcolorKeyword background
syntax keyword vimcolorNone NONE
syntax keyword vimcolorAttrs italic bold dark light
syntax match vimcolorGroup "[A-Z][^ ]*"
syntax match vimcolorColor "#[0-9a-fA-F]\+"
syntax match vimcolorDelims "[,.]" containedin=vimcolorLinkSource
syntax match vimcolorLinkLine "^link .*$" contains=vimcolorLink,vimcolorLinkSource,vimcolorLinkDest
syntax keyword vimcolorLink contained link
syntax match vimcolorLinkSource "\(link \)\@<=[a-zA-Z,]\+" contained
syntax match vimcolorLinkDest "[a-zA-Z]\+$" contained
syntax region vimcolorComment start=/^"/ end="$"

" Perform the actual highlighting
hi def link vimcolorKeyword Keyword
hi def link vimcolorGroup Statement
hi def link vimcolorLinkSource Statement
hi def link vimcolorColor Constant
hi def link vimcolorNone Include
hi def link vimcolorDelims Delimiter
hi def link vimcolorAttrs Type
hi def link vimcolorLink Operator
hi def link vimcolorLinkDest Identifier
hi def link vimcolorComment Comment

let b:current_syntax = "vimcolor"
let &cpo = s:cpo_save
unlet s:cpo_save
