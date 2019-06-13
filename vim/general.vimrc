" vim: foldmethod=marker foldlevel=0
" Update file when changed from the outside
" set autoread

" tags files
set tags=./tags,tags,.git/tags

" matchit.vim is default, why not enable it
runtime macros/matchit.vim

" For editing binaries
set binary

" No swp please, I save all the time
set noswapfile

" make regexes consistent with other programs (extended)
set magic

" directories to search on find, gf, etc.
set path=.,**
set wildignore=**/.git/**,**/__pycache__/**,**/venv/**,**/node_modules/**,**/dist/**,**/build/**,*.o,*.pyc,*.swp
set wildignorecase

" Persistent undos (useful for plugins too){{{
if has('persistent_undo')
  let myUndoDir = expand('$HOME/.vim' . '/undo')
  silent call mkdir(myUndoDir, 'p')
  let &undodir = myUndoDir
  set undofile
endif
" }}}

" Hide buffers instead of closing
set hidden

" Dont redraw while executing macros
set lazyredraw

" Encoding
set encoding=utf-8 nobomb
set fileencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac

" netrw {{{
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'  " hide dotfiles
let g:netrw_banner = 0                          " hide the banner
let g:netrw_liststyle = 3                       " tree view
let g:netrw_winsize = 25                        " open at 25% size
let g:netrw_hide = 1                            " hide hidden files
let g:netrw_preview=1                           " preview window shown in a vertical split
" }}}

" Send more characters at a given time
set ttyfast

" Show partial command on last line
set showcmd

" Command completion
set wildmenu

" Colorscheme
colorscheme default

" Enable dark background
set background=dark

" Enable 256 colormode
" set t_Co=256

" Mouse tweak
set mousemodel=popup

" Status line {{{
set laststatus=2                                                    " Always show status bar
set statusline=%f                                                   " Relative path and filename
set statusline+=\ %m%r%w                                            " Flags (modified, readonly, help, preview)
set statusline+=%#error#                                            " Start error highlighting
set statusline+=%{StatuslineTabWarning()}                           " Inconsistent indentation warning
set statusline+=%{StatuslineTrailingSpaceWarning()}                 " Trailing whitespace warning
set statusline+=%*                                                  " Clear highlighting
set statusline+=%<                                                  " Start truncating here
if exists('g:loaded_fugitive')                                      " If fugitive is in use
  set statusline+=\ %{FugitiveStatusline()}                          "   add fugitive status to the statusline
endif                                                               " end
set statusline+=\ \ %{StatuslineBuildCwd()}                         " Current working directory, replacing home with ~
set statusline+=%=                                                  " Move everything after this to the right
set statusline+=\ %y                                                " File type
set statusline+=\ [%{&expandtab?'spaces':'tabs'},                   " Using spaces or tabs
set statusline+=%{strlen(&shiftwidth)?&shiftwidth:'none'}]          " Spaces in a tab
set statusline+=\ %l/%L\                                            " Cursor line/total lines
set statusline+=\ B%n                                               " Buffer number
set statusline+=\ \ %{strftime(\"%H:%M\")}                          " Time

" recalculate the tab/trailing whitespace warning flags when idle and after writing
augroup statusline
  autocmd!
  autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning
  autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
augroup END

" return '[&et]' if &et is set wrong
" return '[mixed-indenting]' if spaces and tabs are used to indent
" return an empty string if everything is fine
function! StatuslineTabWarning()
  if &readonly || &bt == "nofile"
    return ""
  endif

  if !exists("b:statusline_tab_warning")
    let tabs = search('^\t', 'nw') != 0
    let spaces = search('^ ', 'nw') != 0

    if tabs && spaces
      let b:statusline_tab_warning =  '[mixed-indenting]'
    elseif (spaces && !&et) || (tabs && &et)
      let b:statusline_tab_warning = '[&et]'
    else
      let b:statusline_tab_warning = ''
    endif
  endif
  return b:statusline_tab_warning
endfunction

" return '[\s]' if trailing white space is detected
" return '' otherwise
function! StatuslineTrailingSpaceWarning()
  if &readonly || &bt == "nofile"
    return ""
  endif

  if !exists("b:statusline_trailing_space_warning")
    if search('\s\+$', 'nw') != 0
      let b:statusline_trailing_space_warning = '[\s]'
    else
      let b:statusline_trailing_space_warning = ''
    endif
  endif
  return b:statusline_trailing_space_warning
endfunction

" build the current working directory string
function! StatuslineBuildCwd()
  let cwd = substitute(getcwd(),$HOME,'~','g')
  return "CWD: " . cwd
endfunction
" }}}

highlight ColorColumn ctermbg=233

" How to split new windows
set splitbelow splitright

" Allow per-file settings
set modeline
set modelines=5     "within the first/last 5 lines

" Allow italics
set t_ZH=[3m
set t_ZR=[23m

" Since belloff isn't always an option
if exists("&belloff")
  set belloff=showmatch,esc,shell,wildmode,backspace   " Disable beeping if no match is found
endif

" Command-line autocompletion
set wildmode=longest:list,full

" Add everything to sessions
set sessionoptions=buffers,curdir,folds,globals,localoptions,options,resize,tabpages,terminal
