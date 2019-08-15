setlocal bufhidden=delete
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '|setlocal bufhidden<'
else
  let b:undo_ftplugin = 'setlocal bufhidden<'
endif
