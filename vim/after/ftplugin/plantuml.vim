compiler plantuml
nnoremap <buffer> <leader><CR> :silent !open "%<.png"<CR>:redraw!<CR>
let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'nmapc <buffer>'
let b:undo_ftplugin .= '| setlocal makeprg<'
