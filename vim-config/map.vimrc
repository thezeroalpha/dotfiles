let mapleader=","   " Set the mapleader to be ,

" So I don't have to mash shift all the time
nnoremap ; :

" Fat finger fixes
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
map q: <Nop>

" Custom mappings
nnoremap <leader>dif :Diff<cr>
nnoremap <leader>/ :noh<cr>
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

" Retain visual mode after > and <
vmap < <gv
vmap > >gv

" Move visual block
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" stfu and write the file
cmap w!! w !sudo tee > /dev/null %
