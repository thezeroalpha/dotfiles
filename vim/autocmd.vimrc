augroup configgroup
  autocmd!
  autocmd BufRead,BufNewFile  *.md    setlocal conceallevel=2
  autocmd FileType markdown     setlocal    conceallevel=2 wrap
  autocmd FileType  vim     setlocal    keywordprg=:help
augroup END
