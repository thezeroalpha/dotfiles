inoremap ;1 #
inoremap ;2 ##
inoremap ;3 ###
inoremap ;4 ####
inoremap ;5 #####
inoremap ;6 ######
setlocal makeprg=pandoc\ %:p:S\ -o\ %:p:r:S.pdf\ \&\&\ open\ -g\ %:p:r:S.pdf
setlocal conceallevel=2
setlocal wrap
let b:undo_ftplugin = '|setlocal makeprg< conceallevel< wrap <'
