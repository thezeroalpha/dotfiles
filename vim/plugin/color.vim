command! ColorDarken if color#Test(expand('<cword>')) | exe "normal! \"_c/[a-fA-F0-9]*/e<CR>" . color#Darken(expand('<cword>')) . "<esc>F#" | endif
command! ColorLighten if color#Test(expand('<cword>')) | exe "normal! \"_c/[a-fA-F0-9]*/e<CR>" . color#Lighten(expand('<cword>')) . "<esc>F#" | endif
