" Allow integration with system clipboard (only newest vim)
set clipboard+=unnamed

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
set statusline+=\ %l/%L\                      " cursor line/total lines
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
