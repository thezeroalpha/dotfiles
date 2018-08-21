let mapleader=","   " Set the mapleader to be ,

" So I don't have to mash shift all the time
nnoremap ; :

" NERDTree
nnoremap <leader>f :NERDTreeToggle<cr>

" Disable q: cuz I hate it
map q: <Nop>

" Normal mode shortcuts
nnoremap <leader>dif :Diff<cr>
nnoremap <leader>/ :noh<cr>
nnoremap <leader>b :ls<cr>

" Tab completion
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

" and don't break my colours (U for 'unfuck my screen please')
nnoremap U :syntax sync fromstart<cr>:redraw!<cr>

" Panic button rot13
nnoremap <leader>qq mzggg?G`z

" 'zoom to head level'
nnoremap zh mzzt10<c-u>`z

" Quick switch to shell
noremap <C-s> :sh<cr>
