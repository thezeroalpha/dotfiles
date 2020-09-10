" return '[&et]' if &et is set wrong
" return '[mixed-indenting]' if spaces and tabs are used to indent
" return an empty string if everything is fine
function! statusline#StatuslineTabWarning()
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
function! statusline#StatuslineTrailingSpaceWarning()
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
function! statusline#StatuslineBuildCwd()
  let cwd = substitute(getcwd(),$HOME,'~','g')
  return "(".cwd.")"
endfunction

" get the current fold info
function! statusline#StatuslineFoldmethod()
  if &foldmethod == "indent"
    return "z".&foldlevel.",c".foldlevel(line('.'))
  elseif &foldmethod == "expr"
    return "f:exp,l".&foldlevel
  else
    return "f:".strpart(&foldmethod, 0, 4)
  endif
endfunction

" print the textwrap information (textwidth or wrapmargin)
function! statusline#StatuslineWrapCol()
  if &textwidth == 0 && &wrapmargin == 0 && &wrap
    return "softwrap"
  endif
  if &textwidth == 0
    return "⟺  ".(winwidth(0)-&wrapmargin)."(M".&wrapmargin.")"
  else
    return "⟺  ".&textwidth
  endif
endfunction

function! statusline#StatuslineSpacesUsed()
  if &expandtab
    return (&shiftwidth ># 0 ? &shiftwidth : &tabstop)
  else
    if &shiftwidth ==# &tabstop
      return &shiftwidth
    else
      return &tabstop."s".&shiftwidth
    endif
  endif
endfunction

function! statusline#StatuslineWordCount()
  return wordcount().words . " words"
endfunction

function! statusline#StatuslineVimtexCompiler()
  if exists('b:vimtex.compiler') && b:vimtex.compiler.is_running()
    return '⚙︎ {'.(fnamemodify(b:vimtex.compiler.target_path, ":p:.")).'}'
  endif
  return ''
endfunction

function! statusline#StatuslineRemoteFile()
  if exists('b:netrw_lastfile')
    return ' ('.b:netrw_lastfile.')'
  endif
  return ''
endfunction

