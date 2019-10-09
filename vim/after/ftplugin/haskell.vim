set suffixesadd=.hs
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| set suffixesadd<'
else
  let b:undo_ftplugin = '| set suffixesadd<'
endif
