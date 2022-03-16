compiler sh
let g:sh_fold_enabled= 7
setlocal foldmethod=syntax

let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'let g:sandwich#magicchar#f#patterns = g:sandwich#magicchar#f#default_patterns |'
let b:undo_ftplugin .= 'setlocal makeprg< foldmethod<'
