setlocal bufhidden=delete
nnoremap <buffer><silent> gn :<C-u>silent! call NetrwxSetTreetop()<CR>
let b:undo_ftplugin = '|setlocal bufhidden<'
