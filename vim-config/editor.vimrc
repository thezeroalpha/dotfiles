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
set statusline=\ %F%m\%r%h\ %w
set statusline+=\ \ CWD:\ %r%{getcwd()}%h
set statusline+=%=%l,%c
set statusline+=\ \ B%n

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

