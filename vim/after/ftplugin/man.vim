" Make searching for keywords/options easier
nnoremap <buffer> <leader>/ /^ \+
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
end
let b:undo_ftplugin .= '| nmapc <buffer>'
