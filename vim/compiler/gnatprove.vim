if exists("current_compiler")
  finish
endif
let current_compiler = "gnatprove"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

if !exists('g:gnat.Project_File') || g:gnat.Project_File == ''
  echohl ErrorMsg
  echo "No project file set, use :SetProject"
  echohl None
else
  exe "CompilerSet makeprg=gnatprove\\ -q\\ -P\\ ".escape(g:gnat.Project_File, ' ')
endif
