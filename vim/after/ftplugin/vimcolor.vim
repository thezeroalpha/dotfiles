setlocal makeprg=colgen.rb\ %
autocmd BufWritePost <buffer> silent make | execute 'colorscheme '.expand('%<')
vmap CH <Plug>Colorizer
noremap CC :ColorClear<CR>
