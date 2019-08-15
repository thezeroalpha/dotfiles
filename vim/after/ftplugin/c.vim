nnoremap <buffer> <leader>mm :silent make<CR>\|:redraw!<CR>\|:cwindow<CR>
nnoremap <buffer> <leader>mc :silent make clean<CR>\|:redraw!<CR>
if v:version >= 800
  packadd termdebug
endif
let b:undo_ftplugin .= ''
