function s:RunCommands()
    exe getline('.')
endfunction
map <Plug>VisualRunCommands
      \ :call <SID>RunCommands()<CR>
