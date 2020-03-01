map <buffer> <leader>CH <Plug>Colorizer
nnoremap <buffer> <leader>CC :ColorClear<CR>
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
end
let b:undo_ftplugin .= '|mapc <buffer>'
let b:undo_ftplugin .= '|nmapc <buffer>'
