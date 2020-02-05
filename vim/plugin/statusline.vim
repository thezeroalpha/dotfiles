if exists("g:loaded_statusline") || &cp
  finish
endif

let g:loaded_statusline = 1

set laststatus=2                                                    " Always show status bar
set statusline=%f                                                   " Relative path and filename
set statusline+=\ %m%r%w                                            " Flags (modified, readonly, help, preview)
set statusline+=%#error#                                            " Start error highlighting
set statusline+=%{statusline#StatuslineTabWarning()}                " Inconsistent indentation warning
set statusline+=%{statusline#StatuslineTrailingSpaceWarning()}      " Trailing whitespace warning
set statusline+=%*                                                  " Clear highlighting
set statusline+=%<                                                  " Start truncating here
set statusline+=\ \ %{statusline#StatuslineBuildCwd()}              " Current working directory, replacing home with ~
set statusline+=%=                                                  " Move everything after this to the right
set statusline+=%{&spell?'[spell]\ ':''}                            " Show spellcheck status
set statusline+=%y                                                  " File type
set statusline+=\ [%{&expandtab?'spaces':'tabs'},                   " Using spaces or tabs
set statusline+=%{strlen(&shiftwidth)?&shiftwidth:'none'}]          " Spaces in a tab
set statusline+=\ [%{statusline#StatuslineFoldmethod()}]            " The current foldlevel
set statusline+=\ {%{statusline#StatuslineWrapCol()}}               " Textwidth/wrapmargin info
set statusline+=\ %l/%L\                                            " Cursor line/total lines
set statusline+=\ %{strftime(\"%H:%M\")}\                           " Time

augroup statusline
  " recalculate the tab/trailing whitespace warning flags when idle and after writing
  autocmd!
  autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning
  autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
augroup END
