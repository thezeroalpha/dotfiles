compiler vimcolor
augroup vimcolor_buffer
  autocmd! * <buffer>
  autocmd BufWritePost <buffer> silent make | execute 'colorscheme '.expand('%:p:t:r')
augroup END

map <buffer> <leader>CH <Plug>Colorizer
nnoremap <buffer> <leader>CC :ColorClear<CR>

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
end
let b:undo_ftplugin .= '|setlocal makeprg< '
let b:undo_ftplugin .= '|exe "au! vimcolor_buffer * <buffer>"'
let b:undo_ftplugin .= '|mapc <buffer>'
let b:undo_ftplugin .= '|nmapc <buffer>'
