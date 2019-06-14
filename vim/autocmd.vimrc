augroup sets
  autocmd!
  autocmd BufRead,BufNewFile  *.md    setlocal conceallevel=2
  autocmd InsertEnter * setlocal nocursorline
  autocmd InsertLeave * setlocal cursorline
augroup END

augroup mappings
  autocmd!
  autocmd BufEnter *.tex nnoremap <leader>tt :VimtexTocToggle<CR>
  autocmd BufLeave *.tex nnoremap <leader>tt :TagbarToggle<CR>
augroup END
