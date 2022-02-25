setl makeprg=dot\ -Tsvg\ -O\ %
let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'set makeprg<'
