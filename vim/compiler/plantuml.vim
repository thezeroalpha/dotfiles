if exists("g:current_compiler")
  finish
endif
let g:current_compiler = "plantuml"
if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif
CompilerSet makeprg=plantuml\ %

