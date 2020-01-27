setlocal keywordprg=:help
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
end
let b:undo_ftplugin .= '|setlocal keywordprg<'
