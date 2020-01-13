if v:version >= 800
  packadd termdebug
endif
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| nmapc <buffer>'
else
  let b:undo_ftplugin = 'nmapc <buffer>'
endif
