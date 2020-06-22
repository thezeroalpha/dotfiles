if v:version >= 800
  packadd termdebug
endif
let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'nmapc <buffer>'
