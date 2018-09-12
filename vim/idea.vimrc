" Settings
set number
set showmode
set ignorecase
set hlsearch
set incsearch
set smartcase
set surround

" Commands
command! ListFileTypes echo glob($VIMRUNTIME . '/syntax/*.vim')
command! CDC cd %:p:h
command! Maketab set noet ts=2 | %retab!
command! Diff w !diff % -
command! Diffc w !git diff % -
command! Fuckwindows %s///g

" Abbreviations
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

" Mappings
let mapleader=","

" Command mode
cnoremap w!! w !sudo tee > /dev/null %

" Normal mode
nnoremap ; :
nnoremap q: <Nop>
nnoremap <leader>dif :Diff<cr>
nnoremap <leader>/ :noh<cr>
nnoremap <leader>b :ls<cr>:b<Space>
nnoremap U :syntax sync fromstart<cr>:redraw!<cr>
nnoremap <leader>qq mzggg?G`z
nnoremap zh mzzt10<c-u>`z
nnoremap <leader>dh :DeleteHiddenBuffers<cr>
nnoremap <leader>s :b#<cr>
nnoremap <leader>hs :set list!<cr>
nnoremap <leader>mm :<C-u>marks<CR>:normal! `
nnoremap <leader>ml :<C-u>marks a-z<CR>:normal! `
nnoremap <expr> <silent> 0 col('.') == match(getline('.'),'\S')+1 ? '0' : '^'

" Visual mode
vnoremap < <gv
vnoremap > >gv
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv
