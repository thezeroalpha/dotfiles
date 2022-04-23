if exists("g:current_compiler")
  finish
endif
let g:current_compiler = "typely"
if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif
CompilerSet errorformat=%f:\ Line\ %l\\,\ column\ %c:\ %trror:\ %m
CompilerSet errorformat+=%f:\ %tnfo:\ %m
CompilerSet makeprg=typely\ %
