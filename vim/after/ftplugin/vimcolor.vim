compiler vimcolor
augroup vimcolor_buffer
  autocmd! * <buffer>
  autocmd BufWritePost <buffer> silent make | execute 'colorscheme '.expand('%:p:t:r')
augroup END
vmap <buffer> CH <Plug>Colorizer
noremap <buffer> CC :ColorClear<CR>
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '|setlocal makeprg< '
  let b:undo_ftplugin .= '|exe "au! vimcolor_buffer * <buffer>"'
  let b:undo_ftplugin .= '|vmapc <buffer>'
  let b:undo_ftplugin .= '|nmapc <buffer>'
else
  let b:undo_ftplugin = 'setlocal makeprg< '
  let b:undo_ftplugin .= '|exe "au! vimcolor_buffer * <buffer>"'
  let b:undo_ftplugin .= '|vmapc <buffer>'
  let b:undo_ftplugin .= '|nmapc <buffer>'
endif
