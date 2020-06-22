nnoremap <buffer> <leader>CH :ColorHighlight<CR>
vnoremap <buffer> <leader>CH :ColorHighlight<CR>
nnoremap <buffer> <leader>CC :ColorClear<CR>
vnoremap <buffer> <leader>CC :<C-u>ColorClear<CR>
let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'mapc <buffer>'
let b:undo_ftplugin .= '|nmapc <buffer>'
