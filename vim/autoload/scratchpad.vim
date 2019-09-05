function scratchpad#MarkScratch()
  exe "setlocal textwidth=".(winwidth(0)-7)
  setlocal buftype=nofile
  setlocal filetype=scratch
endfunction
