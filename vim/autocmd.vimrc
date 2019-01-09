augroup configgroup
  autocmd!
  autocmd BufRead,BufNewFile  *.md    setlocal conceallevel=2
  autocmd FileType markdown     setlocal    conceallevel=2 wrap
  autocmd FileType  vim     setlocal    keywordprg=:help
  autocmd FileType vimwiki  setlocal    wrap shiftwidth=4 tabstop=4 softtabstop=4 breakindent breakindentopt=shift:3 | cabbrev table VimwikiTable
  autocmd FileType tagbar   setlocal    nocursorline 
augroup END
