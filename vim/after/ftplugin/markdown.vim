inoremap <buffer> ;1 #
inoremap <buffer> ;2 ##
inoremap <buffer> ;3 ###
inoremap <buffer> ;4 ####
inoremap <buffer> ;5 #####
inoremap <buffer> ;6 ######
compiler markdown
setlocal wrap
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '|setlocal makeprg< conceallevel< wrap <'
else
  let b:undo_ftplugin = 'setlocal makeprg< conceallevel< wrap <'
endif
