if exists("g:loaded_statusline") || &cp
  finish
endif

let g:loaded_statusline = 1

set laststatus=2                                                      " Always show status bar
set statusline=%#statuslinenormmode#%{(mode()=='n')?'\ \ N\ ':''}     " Normal mode indicator
set statusline+=%#DiffAdd#%{(mode()=='i')?'\ \ I\ ':''}               " Insert mode indicator
set statusline+=%#DiffAdd#%{(mode()=='t')?'\ \ T\ ':''}               " Insert mode indicator
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ R\ ':''}            " Replace mode indicator
set statusline+=%#Todo#%{(mode()=='v')?'\ \ V\ ':''}                  " Visual mode indicator
set statusline+=%#Todo#%{(mode()=='s')?'\ \ S\ ':''}                  " Select mode indicator
set statusline+=%#statuslinefile#\ %f                                 " Relative path and filename
set statusline+=\ 〉%*                                                " Separator and clear highlighting
set statusline+=%(\ %m%r%w\ %)                                        " Flags (modified, readonly, help, preview). don't show if empty.
set statusline+=%#error#                                              " Start error highlighting
set statusline+=%(%{statusline#StatuslineTabWarning()}%)              " Inconsistent indentation warning
set statusline+=%*                                                    " Clear highlighting
set statusline+=%{statusline#StatuslineRemoteFile()}
set statusline+=%=                                                    " Move everything after this to the right
set statusline+=%<                                                    " Start truncating here
set statusline+=\ %{statusline#StatuslineBuildCwd()}\                 " Current working directory, replacing home with ~
set statusline+=%#statuslinefile#                                     " Highlight same as filename
set statusline+=%(\ %{&spell?'📖\ ':''}%)                             " Show spellcheck status
set statusline+=%(\ %{statusline#StatuslineVimtexCompiler()}%)        " Vimtex compiler status
set statusline+=%(\ %y\ \|%)                                          " File type
set statusline+=\ %{&expandtab?'⤻':'⥅'}\                              " Using spaces or tabs
set statusline+=%{statusline#StatuslineSpacesUsed()}                  " Spaces in a tab
set statusline+=%(\ \|\ %{&paste?'📋':''}%)                           " Is paste set?
set statusline+=\ \|\ %{statusline#StatuslineWrapCol()}\              " Textwidth/wrapmargin info
set statusline+=\ %#statuslinenormmode#                               " Highlight same as normal mode indicator
set statusline+=\ [%{statusline#StatuslineFoldmethod()}]              " The current foldlevel
set statusline+=\ %l/%L\                                              " Cursor line/total lines
set statusline+=\ %{strftime(\"%H:%M\")}\                             " Time

augroup statusline
  " recalculate the tab/trailing whitespace warning flags when idle and after writing
  autocmd!
  autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning
augroup END

command! StatuslineWCAdd setlocal statusline+=%{statusline#StatuslineWordCount()}
command! StatuslineWCRem setlocal statusline-=%{statusline#StatuslineWordCount()}
