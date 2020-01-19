function! lorem_ipsum#GetParagraphs(num)
  execute "read !curl -sL http://metaphorpsum.com/paragraphs/".a:num
  execute "normal }gw".a:num."{0"
endfunction
