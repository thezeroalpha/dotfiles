setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| set shiftwidth< tabstop< softtabstop< expandtab<'
else
  let b:undo_ftplugin = '| set shiftwidth< tabstop< softtabstop< expandtab<'
endif
