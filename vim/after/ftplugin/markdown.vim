inoremap <buffer> ;1 #
inoremap <buffer> ;2 ##
inoremap <buffer> ;3 ###
inoremap <buffer> ;4 ####
inoremap <buffer> ;5 #####
inoremap <buffer> ;6 ######
compiler markdown
setlocal wrap
setlocal conceallevel=2
nnoremap <buffer> <leader><CR> :silent !open "%<.pdf"<CR>:redraw!<CR>
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| imapc <buffer>'
  let b:undo_ftplugin .= '| nmapc <buffer>'
  let b:undo_ftplugin .= '| setlocal makeprg< conceallevel< wrap<'
else
  let b:undo_ftplugin = ' imapc <buffer>'
  let b:undo_ftplugin = ' nmapc <buffer>'
  let b:undo_ftplugin .= '| setlocal makeprg< conceallevel< wrap<'
endif
