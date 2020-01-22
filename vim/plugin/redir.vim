" Usage:
"   :Redir hi ............. show the full output of command ':hi' in a scratch window
"   :Redir !ls -al ........ show the full output of command ':!ls -al' in a scratch window

if exists("g:loaded_redir") || &cp
  finish
endif
let g:loaded_redir = 1

command! -nargs=1 -complete=command Redir silent call redir#Redir(<f-args>)
