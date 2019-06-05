let mapleader=" "   " Set the mapleader to be space

" So I don't have to mash shift all the time
nnoremap ; :
vnoremap ; :
tnoremap <C-w>; <C-w>:

" Disable q: cuz I hate it
" (also C-F does the same)
nnoremap q: <Nop>

" Normal mode shortcuts
nnoremap <leader>dif :Diff<CR>
nnoremap <leader>b :ls<CR>:b<Space>

" If vim-cool is not installed, add a map to
" disable search highlight
if !exists("g:loaded_cool")
  nnoremap <leader>/ :noh<CR>
endif

" Tab completion (disabled because of ultisnips)
" inoremap <expr> <tab> InsertTabWrapper()
" inoremap <s-tab> <c-p>

" Retain visual mode after > and <
vnoremap < <gv
vnoremap > >gv

" visual j/k
nnoremap j gj
nnoremap k gk

" Move visual block
vnoremap D :m '>+1<CR>gv=gv
vnoremap U :m '<-2<CR>gv=gv

" stfu and write the file
cnoremap sudow w !sudo tee > /dev/null %

" and don't break my colours (U for 'unfuck my screen please')
nnoremap U :syntax sync fromstart<CR>:redraw!<CR>

" 'zoom to head level'
nnoremap zh mzzt10<c-u>`z

" Reindent the file
nnoremap <leader>= mlgg=G`lzz

" Tab mappings
nnoremap <C-t> :tabnew<CR>
nnoremap <C-c> :tabclose<CR>

" Window resizing mappings
nnoremap <C-k> <C-w>+
nnoremap <C-j> <C-w>-
nnoremap <C-h> <C-W>>
nnoremap <C-l> <C-W><

" Delete hidden buffers
nnoremap <leader>dh :DeleteHiddenBuffers<CR>

" Switch to alernative buffer
nnoremap <leader>s<leader> :b#<CR>

" Show hidden symbols
nnoremap <leader>hs :set list!<CR>

" List marks
nnoremap <leader>mm :<C-u>marks<CR>:normal! `
nnoremap <leader>ml :<C-u>marks a-z<CR>:normal! `

" Switch between relative and absolute line num
nnoremap <leader># :call ToggleNumber()<CR>

" Map '0' to act as '^' on first press and '0' on second
nnoremap <expr> <silent> 0 col('.') == match(getline('.'),'\S')+1 ? '0' : '^'

" Highlight last inserted text
nnoremap gV `[v`]

" Save in insert mode
inoremap <C-Z> <C-o>:w<CR>

" Config edit mappings
nnoremap <C-E><C-A> :vsplit $DOTFILES/vim/autocmd.vimrc<CR>
nnoremap <C-E><C-C> :vsplit $DOTFILES/vim/commands.vimrc<CR>
nnoremap <C-E><C-E> :vsplit $DOTFILES/vim/editor.vimrc<CR>
nnoremap <C-E><C-G> :vsplit $DOTFILES/vim/general.vimrc<CR>
nnoremap <C-E><C-V> :vsplit $DOTFILES/vim/init.vimrc<CR>
nnoremap <C-E><C-M> :vsplit $DOTFILES/vim/map.vimrc<CR>
nnoremap <C-E><C-P> :vsplit $DOTFILES/vim/plugins.vimrc<CR>
nnoremap <C-E><C-L> :vsplit $DOTFILES/vim/pluginconf.vimrc<CR>

" Yank to clipboard
nnoremap <leader>d "*d
vnoremap <leader>d "*d
nnoremap <leader>D "*D
nnoremap <leader>y "*y
vnoremap <leader>y "*y
nnoremap <leader>p "*p
nnoremap <leader>P "*P
nnoremap <leader>n "_
vnoremap <leader>n "_

" This should be a plugin but for now...
" time (hh:mm-hh:mm) to duration in hours
nnoremap <leader>td 0f-l"aywf:l"byw0"cywf:l"dywA (=((a*60+b)-(c*60+d))/60.0)F.r:wyw"aywcw=0.a*60F.2xih0:s/:0h/h

" Custom session maps
nnoremap <leader>ss :call SaveSession()<CR>
nnoremap <leader>sl :call LoadSession()<CR>
nnoremap <leader>sd :call DeleteSession()<CR>
nnoremap <leader>sq :call CloseSession()<CR>

" native file browsing
nnoremap <leader>f  :call ToggleNetrw()<CR>

" fall back on native fuzzy find if fzf not installed
" (using :next because :find doesn't do multiple files)
if mapcheck("<leader>F") == ""
  nnoremap <leader>F :next **/*
endif

" Strip trailing whitespace
nnoremap <leader>$ :%s/ \+$//e<CR>
