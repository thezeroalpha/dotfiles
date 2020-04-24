setlocal spell
setlocal spelllang=en
setlocal formatoptions+=cat
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
end
let b:undo_ftplugin .= '|setlocal spell< spelllang< formatoptions<'
