runtime! syntax/conf.vim
unlet b:current_syntax
syntax include @Shell syntax/sh.vim
syntax region lfrcShell start="^ *cmd[^$&%!]\+[$&%!] *{{\zs" end="^\ze *}}" keepend contains=@Shell
syntax match lfrcShellSingle "^ *cmd[^$&%!]\+[$&%!]\zs.*$" contains=@Shell
syntax keyword Statement cmd map set
