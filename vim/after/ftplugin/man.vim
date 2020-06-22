" Make searching for keywords/options easier
nnoremap <buffer> <leader>/ /^ \+
let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'nmapc <buffer>'
