nnoremap <buffer> <leader>tt :VimtexTocToggle
inoremap <buffer> . .<c-g>u
inoremap <buffer> ? ?<c-g>u
inoremap <buffer> ! !<c-g>u
inoremap <buffer> , ,<c-g>u
inoremap <buffer> : :<c-g>u
inoremap <buffer> ; ;<c-g>u
inoremap <buffer> - -<c-g>u

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
end
let b:undo_ftplugin .= '|nmapc <buffer>'
let b:undo_ftplugin .= '|imapc <buffer>'
