setlocal spell
setlocal spelllang=en
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '|setlocal spell< spelllang<'
else
  let b:undo_ftplugin = 'setlocal spell< spelllang<'
endif
