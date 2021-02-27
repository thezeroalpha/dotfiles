compiler groff
let b:nroff_is_groff = 1
setlocal commentstring=\\#\ %s
let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'unlet b:nroff_is_groff'
