function s:Tablature()
    setlocal nospell
    setfiletype markdown
    let lineno = line('.')
    call append(lineno,   '```')
    call append(lineno+1,   'E |-----------------|-----------------|-----------------|---------------------|')
    call append(lineno+2, 'B |-----------------|-----------------|-----------------|---------------------|')
    call append(lineno+3, 'G |-----------------|-----------------|-----------------|---------------------|')
    call append(lineno+4, 'D |-----------------|-----------------|-----------------|---------------------|')
    call append(lineno+5, 'A |-----------------|-----------------|-----------------|---------------------|')
    call append(lineno+6, 'E |-----------------|-----------------|-----------------|---------------------|')
    call append(lineno+7, '```')
    hi! link colorcolumn cursorline
    setlocal colorcolumn=21,39,57,80
endfunction

command Tab call <SID>Tablature()
