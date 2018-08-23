call plug#begin('~/.vim/plugged')
" NERDTree - file browser
Plug 'scrooloose/nerdtree'

" NERD Commenter - simple comment toggling
Plug 'scrooloose/nerdcommenter'

" Emmet - must-have for HTML, awesome snippet expansion
Plug 'mattn/emmet-vim'

" Syntax file etc. for Typescript
Plug 'leafgarland/typescript-vim'

" Sleuth - set tab options based on current file
Plug 'tpope/vim-sleuth'

" Endwise - smart do-end, if-fi, if-end, case-esac, etc.
Plug 'tpope/vim-endwise'

" Visual guides for indent levels
Plug 'nathanaelkane/vim-indent-guides'

" Surround - super useful plugin for surrounding stuff with quotes/brackets/tags
Plug 'tpope/vim-surround'
call plug#end()
