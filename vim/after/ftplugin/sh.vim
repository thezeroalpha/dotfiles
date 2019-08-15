compiler sh
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '|setlocal makeprg<'
else
  let b:undo_ftplugin = 'setlocal makeprg<'
endif
