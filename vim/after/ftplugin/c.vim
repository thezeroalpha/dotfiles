if v:version >= 800
  packadd termdebug
endif
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
end
let b:undo_ftplugin .= '| nmapc <buffer>'
