compiler ada
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '|setlocal makeprg< errorformat<'
else
  let b:undo_ftplugin = 'setlocal makeprg< errorformat<'
endif
