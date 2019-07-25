inoremap <buffer> ;1 #
inoremap <buffer> ;2 ##
inoremap <buffer> ;3 ###
inoremap <buffer> ;4 ####
inoremap <buffer> ;5 #####
inoremap <buffer> ;6 ######
setlocal makeprg=pandoc\ %:p:S\ -o\ %:p:r:S.pdf\ \&\&\ open\ -g\ %:p:r:S.pdf
setlocal conceallevel=2
setlocal wrap
let b:undo_ftplugin = '|setlocal makeprg< conceallevel< wrap <'
