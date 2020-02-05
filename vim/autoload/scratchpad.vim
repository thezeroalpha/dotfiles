function! scratchpad#Create()
  new
  call scratchpad#MarkScratch()
endfunction
function! scratchpad#MarkScratch()
  exe "setlocal textwidth=".(winwidth(0)-7)
  setlocal bufhidden=wipe buftype=nofile nobuflisted noswapfile
endfunction
