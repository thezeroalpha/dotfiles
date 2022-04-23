if exists("g:current_compiler")
  finish
endif
let g:current_compiler = "markdown"
if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif
" potentially call with --citeproc flag
CompilerSet makeprg=pandoc\ %:p:S\ -f\ markdown\ --citeproc\ -o\ %:p:r:S.pdf
