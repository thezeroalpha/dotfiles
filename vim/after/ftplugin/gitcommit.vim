setlocal spell
setlocal spelllang=en
setlocal formatoptions+=cat
let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'setlocal spell< spelllang< formatoptions<'
