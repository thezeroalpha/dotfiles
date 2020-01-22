if exists("g:loaded_delete_hidden_buffers") || &cp
  finish
endif
let g:loaded_delete_hidden_buffers = 1

command! DeleteHiddenBuffers call delete_hidden_buffers#DeleteHiddenBuffers()
nnoremap <Plug>DeleteHiddenBuffers :DeleteHiddenBuffers<CR>
