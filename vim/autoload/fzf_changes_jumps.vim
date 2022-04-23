function s:GoTo(jumpline)
  let values = split(a:jumpline, ":")
  execute "e ".values[0]
  call cursor(str2nr(values[1]), str2nr(values[2]))
  execute "normal zvzz"
endfunction

function s:GetLine(bufnr, lnum)
  let lines = getbufline(a:bufnr, a:lnum)
  if len(lines)>0
    return trim(lines[0])
  else
    return ''
  endif
endfunction

function! fzf_changes_jumps#Jumps()
  " Get jumps with filename added
  let jumps = map(reverse(copy(getjumplist()[0])),
    \ { key, val -> extend(val, {'name': getbufinfo(val.bufnr)[0].name }) })

  let jumptext = map(copy(jumps), { index, val ->
      \ (val.name).':'.(val.lnum).':'.(val.col+1).': '.s:GetLine(val.bufnr, val.lnum) })

  call fzf#run(fzf#vim#with_preview(fzf#wrap({
        \ 'source': jumptext,
        \ 'column': 1,
        \ 'options': ['--delimiter', ':', '--bind', 'alt-a:select-all,alt-d:deselect-all', '--preview-window', '+{2}-/2'],
        \ 'sink': function('s:GoTo')})))
endfunction


function! fzf_changes_jumps#Changes()
  let changes  = reverse(copy(getchangelist()[0]))

  let changetext = map(copy(changes), { index, val ->
      \ expand('%').':'.(val.lnum).':'.(val.col+1).': '.s:GetLine(bufnr('%'), val.lnum) })

  call fzf#run(fzf#vim#with_preview(fzf#wrap({
        \ 'source': changetext,
        \ 'column': 1,
        \ 'options': ['--delimiter', ':', '--bind', 'alt-a:select-all,alt-d:deselect-all', '--preview-window', '+{2}-/2'],
        \ 'sink': function('s:GoTo')})))
endfunction
