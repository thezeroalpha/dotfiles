compiler plantuml
augroup plantuml_buffer
  autocmd! * <buffer>
augroup END
nnoremap <buffer> <leader><CR> :silent !open "%<.png"<CR>:redraw!<CR>
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| nmapc <buffer>'
  let b:undo_ftplugin .= '| setlocal makeprg<'
  let b:undo_ftplugin .= '| exe "au! plantuml_buffer * <buffer>"'
else
  let b:undo_ftplugin = 'nmapc <buffer>'
  let b:undo_ftplugin .= '| setlocal makeprg<'
  let b:undo_ftplugin .= '| exe "au! plantuml_buffer * <buffer>"'
endif
