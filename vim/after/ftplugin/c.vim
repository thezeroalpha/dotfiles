nnoremap <buffer> <leader>mm :silent make<CR>\|:redraw!<CR>\|:cwindow<CR>
nnoremap <buffer> <leader>mc :silent make clean<CR>\|:redraw!<CR>
if v:version >= 800
  packadd termdebug
endif
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| nmapc <buffer>'
else
  let b:undo_ftplugin = 'nmapc <buffer>'
endif
