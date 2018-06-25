" Update file when changed from the outside
set autoread

" For editing binaries
set binary

" Highlight current line
set cursorline

" Hide buffers instead of closing
set hidden

" Line settings
set nowrap
set number
set numberwidth=3

" Indentation settings
" I want spaces
set expandtab

" with a smart tab
set smarttab

" and 1 tab == 4 spaces
set shiftwidth=4
set softtabstop=4
set shiftround
set copyindent

" Linebreak when obsessive
set lbr
set tw=500

" Auto indent
set ai

" Smart indent
set si

" Wrapping
set nowrap

" Status bar
set laststatus=2

" Folding
set foldmethod=indent

" Searching
set ignorecase
set hlsearch
set incsearch
set smartcase

" Show matching brackets
set showmatch
set mat=2

" Dont redraw while executing macros
set lazyredraw

" Set 80-char column (off by default)
" set colorcolumn=80
highlight ColorColumn ctermbg=233

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" netrw configs
let g:netrw_banner = 0

" Backspace tweaks
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

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

" Custom commands
command Todo vimgrep /TODO\C/ **/*.* | copen
command Note vimgrep /NOTE\C/ **/*.* | copen
command Fix vimgrep /FIXME\C/ **/*.* | copen
command CDC cd %:p:h
command Maketab set noet ts=2 | %retab!

" Retain visual mode after > and <
vmap < <gv
vmap > >gv

" Move visual block
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv


" For encoding/formats
set encoding=utf-8 nobomb
set fileformats=unix,dos,mac

" Send more characters at a given time
set ttyfast

" Show partial command on last line
set showcmd

" How to split new windows
set splitbelow splitright

" ======= Colors and Fonts ======== "

" Syntax highlighting
syntax on

" Enable dark background
set background=dark

" Enable 256 colormode
set t_Co=256

" Mouse tweak
set mousemodel=popup

" ====== COMMANDS/MAPPINGS ======= "

let mapleader=","   " Set the mapleader to be ,

" 
nnoremap ; :
map q: <Nop>
cmap w!! w !sudo tee > /dev/null %
