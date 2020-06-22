nnoremap <buffer> <leader>tt :VimtexTocToggle<CR>
nnoremap <buffer> <leader>to :VimtexTocOpen<CR>
inoremap <buffer> . .<c-g>u
inoremap <buffer> ? ?<c-g>u
inoremap <buffer> ! !<c-g>u
inoremap <buffer> , ,<c-g>u
inoremap <buffer> : :<c-g>u
inoremap <buffer> ; ;<c-g>u
inoremap <buffer> - -<c-g>u
setlocal formatoptions-=cat wrap
let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'nmapc <buffer>'
let b:undo_ftplugin .= '|imapc <buffer>'
let b:undo_ftplugin .= '|setlocal formatoptions< wrap<'
