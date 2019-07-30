if exists("g:loaded_sessions") || &cp
  finish
endif

let g:loaded_sessions = 1

noremap <silent> <unique> <script> <Plug>SaveSession :call sessions#SaveSession()<CR>
noremap <silent> <unique> <script> <Plug>LoadSession :call sessions#LoadSession()<CR>
noremap <silent> <unique> <script> <Plug>DeleteSession :call sessions#DeleteSession()<CR>
noremap <silent> <unique> <script> <Plug>CloseSession :call sessions#CloseSession()<CR>
