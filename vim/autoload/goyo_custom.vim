" Unfortunately I had to do this in a super convoluted way, because of the way statusline is refreshed
function! goyo_custom#set_wordcount()
  let g:goyo_wordcount = wordcount().words
endfunction
function! goyo_custom#update_ruler()
  call goyo_custom#set_wordcount()
  " Adding the call to wordcount() here didn't work, so had to use a helper variable
  setlocal rulerformat=%20(%{g:goyo_wordcount}\ words%=\ %{strftime(\"%H:%M\")}%)
endfunction
function! goyo_custom#modify_hlgroups()
  hi! spellbad gui=underline cterm=underline
  hi! spellcap gui=underline cterm=underline
endfunction
function! goyo_custom#goyo_enter()
  call goyo_custom#update_ruler()
  setlocal textwidth=0 wrapmargin=0 wrap linebreak spell scrolloff=0
  call goyo_custom#modify_hlgroups()
  setlocal ruler
  autocmd BufEnter,BufReadPost,BufWritePost,TextChanged,TextChangedI * call goyo_custom#update_ruler()
  Limelight
endfunction
function! goyo_custom#goyo_leave()
  setlocal textwidth< wrapmargin< linebreak< wrap< rulerformat< ruler< spell< scrolloff
  autocmd! BufEnter,BufReadPost,BufWritePost,TextChanged,TextChangedI
  execute "colorscheme ".g:colors_name
  unlet g:goyo_wordcount
  Limelight!
endfunction
