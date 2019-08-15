compiler vimcolor
augroup vimcolor_buffer
  autocmd! * <buffer>
  autocmd BufWritePost <buffer> silent make | execute 'colorscheme '.expand('%:p:t:r')
augroup END
vmap <buffer> CH <Plug>Colorizer
noremap <buffer> CC :ColorClear<CR>
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '|setlocal makeprg< | exe "au! vimcolor_buffer * <buffer>"'
else
  let b:undo_ftplugin = 'setlocal makeprg< | exe "au! vimcolor_buffer * <buffer>"'
endif
