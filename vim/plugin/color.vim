command! ColorDarken if color#Test(expand('<cword>')) | exe "normal! \"_c/\\>/e<CR>" . color#Darken(expand('<cword>')) . "<esc>F#" | endif
command! ColorLighten if color#Test(expand('<cword>')) | exe "normal! \"_c/\\>/e<CR>" . color#Lighten(expand('<cword>')) . "<esc>F#" | endif
