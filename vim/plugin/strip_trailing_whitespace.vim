" function s:StripTrailingWhitespace()
"   if !&binary && &filetype != 'diff'
"     normal m`
"     %s/\s\+$//e
"     normal ``
"   endif
" endfunction
function s:StripTrailingWhitespace()
  if &filetype != 'diff'
    normal m`
    %s/\s\+$//e
    normal ``
  endif
endfunction
nnoremap <Plug>StripTrailingWhitespace
      \ :call <SID>StripTrailingWhitespace()<CR>
