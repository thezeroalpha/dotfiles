setlocal spell
setlocal spelllang=en
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
end
let b:undo_ftplugin .= '|setlocal spell< spelllang<'
