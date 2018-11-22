augroup configgroup
  autocmd!
  autocmd BufRead,BufNewFile  *.md    setlocal conceallevel=2
  autocmd FileType markdown     setlocal    conceallevel=2 wrap
  autocmd FileType  vim     setlocal    keywordprg=:help
  autocmd FileType vimwiki  setlocal    wrap shiftwidth=4 tabstop=4 softtabstop=4 | cabbrev table VimwikiTable
augroup END
