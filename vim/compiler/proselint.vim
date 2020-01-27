if exists("current_compiler")
  finish
endif
let current_compiler = "proselint"
if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif
CompilerSet errorformat=%f:%l:%c:\ %m
CompilerSet makeprg=proselint\ %
