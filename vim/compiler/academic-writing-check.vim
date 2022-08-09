
if exists("g:current_compiler")
  finish
endif
let g:current_compiler = "academic-writing-check"
if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif
CompilerSet makeprg=academic-writing-check\ -v\ %
CompilerSet errorformat=%E%f:%l:\ %m
