" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Clear the syntax
syntax clear

" Define highlighting groups
syntax region mapComment start="^#" end="$"
syntax match mapDash "\(^ *\)\@<=-"
syntax match mapSource "[a-zA-Z0-9_\-./]\+:"
syntax match mapDest "\(: \)\@<=.\+" "have to use lookbehind here, \zs breaks it

" Perform the actual highlighting
hi def link mapComment Comment
hi def link mapSource Statement
hi def link mapDash Function
hi def link mapDest String

let b:current_syntax = "map"
let &cpo = s:cpo_save
unlet s:cpo_save
