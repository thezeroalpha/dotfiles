augroup configgroup
  autocmd!
  autocmd BufRead,BufNewFile  *.md    setlocal conceallevel=2
  autocmd FileType markdown     setlocal    conceallevel=2 wrap
  autocmd FileType  vim     setlocal    keywordprg=:help
  autocmd FileType vimwiki  setlocal    wrap shiftwidth=4 tabstop=4 softtabstop=4 breakindent breakindentopt=shift:3 | cabbrev table VimwikiTable
  autocmd FileType tagbar   setlocal    nocursorline 
  autocmd FileType qf       setlocal    nocursorline
augroup END

augroup insertbinds
  autocmd!
  autocmd FileType markdown inoremap ;1 #
  autocmd FileType markdown inoremap ;2 ##
  autocmd FileType markdown inoremap ;3 ###
  autocmd FileType markdown inoremap ;4 ####
  autocmd FileType markdown inoremap ;5 #####
  autocmd FileType markdown inoremap ;6 ######
augroup END

augroup mappings
  autocmd!
  autocmd FileType c nnoremap <leader>mm :silent make<CR>\|:redraw!<CR>\|:cwindow<CR>
  autocmd FileType c nnoremap <leader>mc :silent make clean<CR>\|:redraw!<CR>
augroup END
