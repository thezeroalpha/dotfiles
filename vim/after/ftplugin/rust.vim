" if exists('g:loaded_dispatch')
"   nnoremap <buffer> <leader>mm :Make build<CR>
" else
"   nnoremap <buffer> <leader>mm :make build<CR>
" endif
setlocal formatprg=rustfmt
setlocal keywordprg=rustup\ doc
let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'setlocal formatprg< keywordprg<'
" let b:undo_ftplugin .= '| nunmap <buffer> <leader>mm'
