setlocal makeprg=colgen.rb\ %
autocmd BufWritePost <buffer> silent make | execute 'colorscheme '.expand('%:p:t:r')
vmap CH <Plug>Colorizer
noremap CC :ColorClear<CR>
