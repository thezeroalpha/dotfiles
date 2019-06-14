inoremap ;1 #
inoremap ;2 ##
inoremap ;3 ###
inoremap ;4 ####
inoremap ;5 #####
inoremap ;6 ######
setlocal makeprg=pandoc\ %\ -o\ %<.pdf
setlocal conceallevel=2
setlocal wrap
let b:undo_ftplugin = '|setlocal makeprg< conceallevel< wrap <'
