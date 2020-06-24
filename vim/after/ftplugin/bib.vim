command! BibOpenFile exe 'call system("open '.findfile(expand("<cfile>")).'")'
nnoremap go :BibOpenFile<CR>
