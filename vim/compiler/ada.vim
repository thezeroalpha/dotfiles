if exists("current_compiler")
  finish
endif
let current_compiler = "ada"
if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif
CompilerSet makeprg=gnatmake\ %
CompilerSet errorformat=%f:%l:%c:\ %m,%f:%l:%c:\ %tarning:\ %m,%f:%l:%c:\ (%ttyle)\ %m
