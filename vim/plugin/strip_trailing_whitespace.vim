function s:StripTrailingWhitespace()
  if &filetype != 'diff'
    normal m`
    %s/\s\+$//e
    normal ``
  endif
endfunction
nnoremap <Plug>StripTrailingWhitespace
      \ :call <SID>StripTrailingWhitespace()<CR>
