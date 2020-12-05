if exists("current_compiler")
  finish
endif
let current_compiler = "markdown"
if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif
" potentially call with --citeproc flag
CompilerSet makeprg=pandoc\ %:p:S\ -f\ markdown\ --citeproc\ -o\ %:p:r:S.pdf\ \&\&\ open\ -g\ %:p:r:S.pdf
