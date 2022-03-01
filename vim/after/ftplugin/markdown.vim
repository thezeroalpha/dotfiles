" Mappings
inoremap <buffer> ;1 #
inoremap <buffer> ;2 ##
inoremap <buffer> ;3 ###
inoremap <buffer> ;4 ####
inoremap <buffer> ;5 #####
inoremap <buffer> ;6 ######

" Add an undo point at punctuation
inoremap <buffer> . .<c-g>u
inoremap <buffer> ? ?<c-g>u
inoremap <buffer> ! !<c-g>u
inoremap <buffer> , ,<c-g>u
inoremap <buffer> : :<c-g>u
inoremap <buffer> ; ;<c-g>u
inoremap <buffer> - -<c-g>u

nnoremap <buffer> <leader><CR> :silent !open %:p:r:S.pdf<CR>:redraw!<CR>
nnoremap <buffer> <leader>` :<C-u>EvalBlock<CR>

nmap <buffer> <leader>ce <Plug>LitMdExecPrevBlock
nmap <buffer> <leader>ct <Plug>LitMdTangle

" Settings
compiler markdown
setlocal wrap textwidth=0 wrapmargin=0 linebreak conceallevel=2 shiftwidth=4 spell

" Undo_ftplugin
let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'imapc <buffer>'
let b:undo_ftplugin .= '| nmapc <buffer>'
" let b:undo_ftplugin .= '| execute "au! markdown_autocmds * <buffer>"'
let b:undo_ftplugin .= '| setlocal makeprg< wrap< textwidth< wrapmargin< linebreak< conceallevel< shiftwidth< spell<'
