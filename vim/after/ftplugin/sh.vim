setlocal makeprg=shellcheck\ -f\ gcc\ %
let b:undo_ftplugin .= '|setlocal makeprg<'
