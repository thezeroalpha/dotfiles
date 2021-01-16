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

" Set up folding. By default use indent, fdm=expr can be set in modeline.
setlocal foldmethod=indent
setlocal foldexpr=vimtex#fold#level(v:lnum)
setlocal foldtext=vimtex#fold#text()
setlocal expandtab
let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'nmapc <buffer>'
let b:undo_ftplugin .= '|imapc <buffer>'
let b:undo_ftplugin .= '|setlocal formatoptions< wrap< foldmethod< foldexpr< foldtext<'
