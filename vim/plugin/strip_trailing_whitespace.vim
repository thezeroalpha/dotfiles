function s:StripTrailingWhitespace()
  if &filetype != 'diff'
    normal m`
    %s/\s\+$//e
    normal ``
  endif
endfunction
command StripTrailingWhitespace call <SID>StripTrailingWhitespace()
nnoremap <Plug>StripTrailingWhitespace
      \ :call <SID>StripTrailingWhitespace()<CR>
