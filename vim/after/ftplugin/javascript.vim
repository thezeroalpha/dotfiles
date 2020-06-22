runtime! ftplugin/html/sparkup.vim
setlocal suffixesadd =.js,.ts
let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'setlocal suffixesadd<'
