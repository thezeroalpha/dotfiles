function! goyo_custom#goyo_enter()
  setlocal textwidth=0 wrapmargin=5 wrap
  setlocal rulerformat=%=%y\ \ %{strftime(\"%H:%M\")}
  setlocal ruler
endfunction
function! goyo_custom#goyo_leave()
  setlocal textwidth< wrapmargin< wrap< rulerformat< ruler<
endfunction
