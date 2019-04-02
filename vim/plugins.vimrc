" vim: foldmethod=marker foldlevel=0:
" Install vim-plug if needed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" A color table with xterm color codes
Plug 'guns/xterm-color-table.vim'

" NERDTree - file browser
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

" NERD Commenter - simple comment toggling {{{
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
" }}}

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

" Markdown in vim (better than built-in)
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Tagbar {{{
Plug 'majutsushi/tagbar'
" tagbar language definitions
let g:tagbar_type_vimwiki = {
          \   'ctagstype':'vimwiki'
          \ , 'kinds':['h:header']
          \ , 'sro':'&&&'
          \ , 'kind2scope':{'h':'header'}
          \ , 'sort':0
          \ , 'ctagsbin':'$CONF_DIR/scripts/vwtags.py'
          \ , 'ctagsargs': 'default'
          \ }

let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ],
    \ 'sort': 0
\ }
" }}}

" Vimwiki {{{
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '$HOME/Dropbox/vimwiki', 
	    \ 'template_path': '$HOME/Dropbox/vimwiki/templates',
	    \ 'template_default': 'default',
	    \ 'template_ext': '.html'}]

let g:vimwiki_global_ext = 1
let g:vimwiki_ext2syntax = {'.mkd': 'markdown',
	    \ '.wiki': 'default'}
let tlist_vimwiki_settings = 'wiki;h:Headers'
" }}}

" Git wrapper from tpope
Plug 'tpope/vim-fugitive'

" Undo tree visualiser
Plug 'simnalamburt/vim-mundo'

" Quickfix window settings/mappings {{{
Plug 'romainl/vim-qf'
nmap ]q <Plug>(qf_qf_next)
nmap [q <Plug>(qf_qf_previous)
nmap <leader>qf <Plug>(qf_qf_toggle)
" }}}

" Repeat everything with '.'
Plug 'tpope/vim-repeat'

" Distraction-free editing
Plug 'junegunn/goyo.vim'

" Better CSV editing
Plug 'chrisbra/csv.vim'

" Display ANSI color codes
Plug 'vim-scripts/AnsiEsc.vim'
 
" Disable hlsearch after finished searching
Plug 'romainl/vim-cool'

" Easy table making (unnecessary because vimwiki has this built in)
"   but leaving in case I need it sometime.
" Plug 'dhruvasagar/vim-table-mode'

call plug#end()
