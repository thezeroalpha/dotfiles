setlocal formatprg=jq
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| set formatprg<'
else
  let b:undo_ftplugin = '| set formatprg<'
endif
