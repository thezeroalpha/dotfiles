let mapleader=","   " Set the mapleader to be ,

" So I don't have to mash shift all the time
nnoremap ; :
vnoremap ; :

" NERDTree
nnoremap <leader>f :NERDTreeToggle<cr>

" Tagbar
nnoremap <leader>t :TagbarToggle<cr>

" Disable q: cuz I hate it
nnoremap q: <Nop>

" Normal mode shortcuts
nnoremap <leader>dif :Diff<cr>
nnoremap <leader>/ :noh<cr>
nnoremap <leader>b :ls<cr>:b<Space>

" Tab completion
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-p>

" Retain visual mode after > and <
vnoremap < <gv
vnoremap > >gv

" Move visual block
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" stfu and write the file
cnoremap w!! w !sudo tee > /dev/null %

" and don't break my colours (U for 'unfuck my screen please')
nnoremap U :syntax sync fromstart<cr>:redraw!<cr>

" Panic button rot13
nnoremap <leader>qq mzggg?G`z

" 'zoom to head level'
nnoremap zh mzzt10<c-u>`z

" Reindent the file
nnoremap <leader>= mlgg=G`lzz

" Tab mappings
nnoremap <C-t> :tabnew<cr>
nnoremap <C-c> :tabclose<cr>

" Window resizing mappings
nnoremap <C-k> <C-w>+
nnoremap <C-j> <C-w>-
nnoremap <C-h> <C-W>>
nnoremap <C-l> <C-W><

" Delete hidden buffers
nnoremap <leader>dh :DeleteHiddenBuffers<cr>

" Switch to alernative buffer
nnoremap <leader>s :b#<cr>

" Show hidden symbols
nnoremap <leader>hs :set list!<cr>

" List marks
nnoremap <leader>mm :<C-u>marks<CR>:normal! `
nnoremap <leader>ml :<C-u>marks a-z<CR>:normal! `

" Switch between relative and absolute line num
nnoremap <leader>n :call ToggleNumber()<CR>

" Map '0' to act as '^' on first press and '0' on second
nnoremap <expr> <silent> 0 col('.') == match(getline('.'),'\S')+1 ? '0' : '^'

" Highlight last inserted text
nnoremap gV `[v`]

" Delete without yanking to clipboard
noremap <leader>d "_d

" Change without yanking to clipboard
nnoremap <leader>C "_c

" Replace without yanking to clipboard
vnoremap <leader>p "_dP
nnoremap <leader>p "_ddP

" Save in insert mode
inoremap <C-Z> <ESC>:w<CR>a

" Config edit mappings
nnoremap <C-E><C-A> :vsplit $CONF_DIR/vim/autocmd.vimrc<CR>
nnoremap <C-E><C-C> :vsplit $CONF_DIR/vim/commands.vimrc<CR>
nnoremap <C-E><C-E> :vsplit $CONF_DIR/vim/editor.vimrc<CR>
nnoremap <C-E><C-G> :vsplit $CONF_DIR/vim/general.vimrc<CR>
nnoremap <C-E><C-V> :vsplit $CONF_DIR/vim/init.vimrc<CR>
nnoremap <C-E><C-M> :vsplit $CONF_DIR/vim/map.vimrc<CR>
nnoremap <C-E><C-P> :vsplit $CONF_DIR/vim/plugins.vimrc<CR>

" This should be a plugin but for now...
" time (hh:mm-hh:mm) to duration in hours
nnoremap <leader>>td 0f-l"aywf:l"byw0w"cywf:l"dywA (=((a*60+b)-(c*60+d))/60.0)F.r:wyw"aywcw=0.a*60F.xxih0:s/:0h/h
