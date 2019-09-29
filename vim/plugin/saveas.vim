function! s:saveas()
  let cursor_pos = repeat("\<Left>", len(expand("%:e"))+1)
  return "saveas ".expand("%:p").cursor_pos
endfunction
cnoreabbrev <expr> san <SID>saveas()
