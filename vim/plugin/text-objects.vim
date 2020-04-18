" Adapted from https://gist.github.com/romainl/c0a8b57a36aec71a986f1120e1931f20
" text objects for symbols
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#' ]
    execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
    execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
    execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
    execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" Buffer text object
xnoremap i& :<C-u>let z = @/\|1;/^./kz<CR>G??<CR>:let @/ = z<CR>V'z
onoremap i& :<C-u>normal vi&<CR>
xnoremap a& GoggV
onoremap a& :<C-u>normal va&<CR>

" 'Up to current line' text object
vnoremap u :<C-u>silent! normal! ggV``<CR>
onoremap u :normal Vu<CR>``

" aliases
xnoremap ir i[
xnoremap ar a[

" number text object (integer and float)
" --------------------------------------
" in
function! s:VisualNumber()
    call search('\d\([^0-9\.]\|$\)', 'cW')
    normal v
    call search('\(^\|[^0-9\.]\d\)', 'becW')
endfunction
xnoremap in :<C-u>call <SID>VisualNumber()<CR>
onoremap in :<C-u>normal vin<CR>

" last change text object
" -----------------------
xnoremap ik `]o`[
onoremap ik :<C-u>normal vik<CR>
onoremap ak :<C-u>normal vikV<CR>

