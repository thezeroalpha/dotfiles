setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| set shiftwidth< tabstop< softtabstop< expandtab<'
else
  let b:undo_ftplugin = '| set shiftwidth< tabstop< softtabstop< expandtab<'
endif
