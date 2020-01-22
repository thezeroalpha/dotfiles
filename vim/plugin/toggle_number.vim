if exists("g:loaded_toggle_number") || &cp
  finish
endif
let g:loaded_toggle_number = 1

" Switch between relative and absolute line num
nnoremap <Plug>ToggleNumber :call toggle_number#ToggleNumber()<CR>
