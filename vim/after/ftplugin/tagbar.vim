setlocal nocursorline
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '|setlocal nocursorline<'
else
  let b:undo_ftplugin = 'setlocal nocursorline<'
endif
