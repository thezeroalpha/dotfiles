"
" Custom commands
command! ListFileTypes echo glob($VIMRUNTIME . '/syntax/*.vim')
command! CDC cd %:p:h
command! Maketab set noet ts=2 | %retab!
command! Diff w !diff % -
command! Diffc w !git diff % -
command! Fuckwindows %s///g

" Fat finger fixes/convenience abbreviations
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
cnoreabbrev E Explore
cnoreabbrev Colors XtermColorTable

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
" also, shift by 4 spaces
set shiftwidth=4
set softtabstop=4
set shiftround
set copyindent

" Auto indent
set autoindent 

" Smart indent
set smartindent

" Folding
set foldmethod=indent

" Status bar
set laststatus=2                            " Always show status bar
set statusline=\ %F                         " Full path
set statusline+=\ %m%r%h%w                  " Flags (modified, readonly, help, preview)
set statusline+=\ %y                        " File type
set statusline+=\ \ CWD:\ %r%{getcwd()}%h   " Current working directory
set statusline+=%=                          " Left/right separator
set statusline+=%c\                         " cursor column
set statusline+=%l/%L\                      " cursor line/total lines
set statusline+=\ B%n                       " Buffer number
set statusline+=\ \ %{strftime(\"%H:%M\")}  " time

" Show matching brackets
set showmatch
set matchtime=2

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

" Better completion
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview
"====== GENERAL ======"
" Update file when changed from the outside
" set autoread

" matchit.vim is default, why not enable it
runtime macros/matchit.vim

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

" Command completion
set wildmenu

" ======= Colors and Fonts ======== "
" Syntax highlighting
syntax on

" Filetype-specific indenting
filetype plugin indent on

" Colorscheme
colorscheme default

" Enable dark background
set background=dark

" Enable 256 colormode
set t_Co=256

" Mouse tweak
set mousemodel=popup
source $HOME/.dotfiles/vim/plugins.vimrc
source $HOME/.dotfiles/vim/general.vimrc
source $HOME/.dotfiles/vim/editor.vimrc
source $HOME/.dotfiles/vim/commands.vimrc
source $HOME/.dotfiles/vim/map.vimrc
let mapleader=","   " Set the mapleader to be ,

" So I don't have to mash shift all the time
nnoremap ; :

" Disable q: cuz I hate it
nnoremap q: <Nop>

" Normal mode shortcuts
nnoremap <leader>dif :Diff<cr>
nnoremap <leader>/ :noh<cr>
nnoremap <leader>b :ls<cr>:b<Space>

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

" Delete hidden buffers
nnoremap <leader>dh :DeleteHiddenBuffers<cr>

" Switch to alernative buffer
nnoremap <leader>s :b#<cr>

" Show hidden symbols
nnoremap <leader>hs :set list!<cr>

" List marks
nnoremap <leader>mm :<C-u>marks<CR>:normal! `
nnoremap <leader>ml :<C-u>marks a-z<CR>:normal! `

" Map '0' to act as '^' on first press and '0' on second
nnoremap <expr> <silent> 0 col('.') == match(getline('.'),'\S')+1 ? '0' : '^'

set surround
