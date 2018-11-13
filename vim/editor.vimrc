"====== EDITING PREFERENCES ======"
" Syntax highlighting
syntax on

" Filetype-specific indenting
filetype plugin indent on

" In general, don't want anything concealed
set conceallevel=0

" Highlight current line
set cursorline

" Text wrap sucks
set nowrap

" Linebreak when obsessive
set linebreak
set textwidth=500

" Numbered lines
set number
set numberwidth=3

" I want spaces
set expandtab

" with a smart tab
set smarttab

" and 1 tab == 4 spaces
set shiftwidth=4    " when >>
set tabstop=4       " visually
set softtabstop=4   " and when editing
set shiftround      " always shift by multiple of shiftwidth
set copyindent      " smart indent based on file

" Auto indent when starting new line
set autoindent 
set smartindent

" Folding on indentation
set foldmethod=indent
set foldlevelstart=5    " start with up to 5 levels open
set foldnestmax=10      " unless callback-hell JS

" Show matching brackets
set showmatch
set matchtime=2

" Since belloff isn't always an option
if exists("&belloff")
    set belloff=showmatch   " Disable beeping if no match is found
endif

" Searching
set hlsearch    " highlight matches
set incsearch   " search while typing
set ignorecase  " ignore case generally
set smartcase   " but not if searching for capital

" Backspace tweaks
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" Better completion
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

" Keep cursor off top and bottom of screen
set scrolloff=5
