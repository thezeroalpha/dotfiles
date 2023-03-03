setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'setlocal tabstop< softtabstop< shiftwidth< expandtab<'
