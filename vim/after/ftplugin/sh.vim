compiler sh
let g:sh_fold_enabled= 7
setlocal foldmethod=syntax

let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'setlocal makeprg< foldmethod<'
