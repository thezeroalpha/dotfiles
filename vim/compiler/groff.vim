if exists("g:current_compiler")
  finish
endif
let g:current_compiler = "groff"
if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif
CompilerSet makeprg=groff\ -ms\ -kept\ -T\ pdf\ %\ >\ %<.pdf
