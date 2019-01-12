if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" A color table with xterm color codes
Plug 'guns/xterm-color-table.vim'

" NERDTree - file browser
Plug 'scrooloose/nerdtree'

" NERD Commenter - simple comment toggling
Plug 'scrooloose/nerdcommenter'

" Emmet - must-have for HTML, awesome snippet expansion
Plug 'mattn/emmet-vim'

" Sleuth - set tab options based on current file
Plug 'tpope/vim-sleuth'

" Endwise - smart do-end, if-fi, if-end, case-esac, etc.
Plug 'tpope/vim-endwise'

" Surround - super useful plugin for surrounding stuff with quotes/brackets/tags
Plug 'tpope/vim-surround'

" Eunuch - shell commands but in vim
Plug 'tpope/vim-eunuch'

" Delete hidden unused buffers
Plug 'arithran/vim-delete-hidden-buffers'

" Markdown in vim (better than built-in)
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Tagbar
Plug 'majutsushi/tagbar'

" Personal wiki
Plug 'vimwiki/vimwiki'

" Git wrapper from tpope
Plug 'tpope/vim-fugitive'

" Undo tree visualiser
Plug 'simnalamburt/vim-mundo'

" Quickfix window settings/mappings
Plug 'romainl/vim-qf'

" Easy table making (unnecessary because vimwiki has this built in)
" Plug 'dhruvasagar/vim-table-mode'

call plug#end()
