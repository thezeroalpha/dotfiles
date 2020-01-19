if exists("g:loaded_lorem_ipsum") || &cp
  finish
endif

let g:loaded_lorem_ipsum = 1
command! -nargs=1 Lorem call lorem_ipsum#GetParagraphs(<args>)
