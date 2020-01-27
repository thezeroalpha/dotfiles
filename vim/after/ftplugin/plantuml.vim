compiler plantuml
nnoremap <buffer> <leader><CR> :silent !open "%<.png"<CR>:redraw!<CR>
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
end
let b:undo_ftplugin .= '| nmapc <buffer>'
let b:undo_ftplugin .= '| setlocal makeprg<'
