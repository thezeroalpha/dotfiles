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
set laststatus=2                            " Always show status bar
set statusline=\ %F%m\%r%h\ %w              " Full path, flags (modified, readonly, help, preview)
set statusline+=\ \ CWD:\ %r%{getcwd()}%h   " Current working directory
set statusline+=%=%l,%c                     " Line number, column number
set statusline+=\ %y                        " File type
set statusline+=\ \ B%n                     " Buffer number

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

" Better completion
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview
