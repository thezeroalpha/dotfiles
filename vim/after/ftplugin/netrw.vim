setlocal bufhidden=delete
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
end
let b:undo_ftplugin .= '|setlocal bufhidden<'
