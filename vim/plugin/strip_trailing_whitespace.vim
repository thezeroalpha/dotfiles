function s:StripTrailingWhitespace()
  if exists('b:keep_trailing_space')
    return
  endif
  if &filetype != 'diff'
    normal m`
    %s/\s\+$//e
    normal ``
  endif
endfunction
command StripTrailingWhitespace call <SID>StripTrailingWhitespace()
nnoremap <Plug>StripTrailingWhitespace
      \ :call <SID>StripTrailingWhitespace()<CR>
