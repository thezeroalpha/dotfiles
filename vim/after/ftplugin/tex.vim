nnoremap <buffer> <leader>tt :VimtexTocToggle
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
end
let b:undo_ftplugin .= '|nmapc <buffer>'
