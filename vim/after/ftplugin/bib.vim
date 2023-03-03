command! BibOpenFile exe 'call system("open '.findfile(expand("<cfile>")).'")'
nnoremap go :BibOpenFile<CR>

setlocal suffixesadd+=.pdf
let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'setlocal suffixesadd<'

function! s:NextSection(backwards, visual)
  if a:visual
    normal! gv
  endif
  let pattern = '\v(^\@[a-zA-Z]+\{)|%^|%$'
  execute 'silent normal! ' . (a:backwards ? '?' : '/') . pattern . (a:backwards ? '?' : '/') . "b\r"
endfunction

noremap <script> <buffer> <silent> ]]
        \ :call <SID>NextSection(0, 0)<cr>

noremap <script> <buffer> <silent> [[
        \ :call <SID>NextSection(1, 0)<cr>

noremap <script> <buffer> <silent> ][
        \ :call <SID>NextSection(0, 0)<cr>

noremap <script> <buffer> <silent> []
        \ :call <SID>NextSection(1, 0)<cr>

vnoremap <script> <buffer> <silent> ]]
        \ :<c-u>call <SID>NextSection(0, 1)<cr>

vnoremap <script> <buffer> <silent> [[
        \ :<c-u>call <SID>NextSection(1, 1)<cr>

vnoremap <script> <buffer> <silent> ][
        \ :<c-u>call <SID>NextSection(0, 1)<cr>

vnoremap <script> <buffer> <silent> []
        \ :<c-u>call <SID>NextSection(1, 1)<cr>
