"====== GENERAL ======"
" Update file when changed from the outside
set autoread

" For editing binaries
set binary

" No swp please, I save all the time
set noswapfile

" Hide buffers instead of closing
set hidden

" Dont redraw while executing macros
set lazyredraw

" Encoding
set encoding=utf-8 nobomb
set fileencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac

" Hide the annoying banner in netrw explorer
let g:netrw_banner = 0

" Send more characters at a given time
set ttyfast

" Show partial command on last line
set showcmd

" ======= Colors and Fonts ======== "
" Syntax highlighting
syntax on

" Enable dark background
set background=dark

" Enable 256 colormode
set t_Co=256

" Mouse tweak
set mousemodel=popup

"====== EDITOR ======"
" Highlight current line
set cursorline

" Text wrap sucks
set nowrap

" Linebreak when obsessive
set lbr
set tw=500

" Numbered lines
set number
set numberwidth=3

" I want spaces
set expandtab

" with a smart tab
set smarttab

" and 1 tab == 4 spaces
set shiftwidth=4
set softtabstop=4
set shiftround
set copyindent

" Auto indent
set ai

" Smart indent
set si

" Folding
set foldmethod=indent

" Status bar
set laststatus=2

" Show matching brackets
set showmatch
set mat=2

" Searching
set ignorecase
set hlsearch
set incsearch
set smartcase

" Set 80-char column (off by default)
" set colorcolumn=80
highlight ColorColumn ctermbg=233

" Backspace tweaks
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" How to split new windows
set splitbelow splitright

"====== COMMANDS ======"
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

" Custom commands
command Todo vimgrep /TODO\C/ **/*.* | copen
command Note vimgrep /NOTE\C/ **/*.* | copen
command Fix vimgrep /FIXME\C/ **/*.* | copen
command CDC cd %:p:h
command Maketab set noet ts=2 | %retab!
command Diff w !diff % -
command Diffc w !git diff % -
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction


" Retain visual mode after > and <
vmap < <gv
vmap > >gv

" Move visual block
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" stfu and write the file
cmap w!! w !sudo tee > /dev/null %
