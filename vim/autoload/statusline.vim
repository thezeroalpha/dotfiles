" return '[&et]' if &et is set wrong
" return '[mixed-indenting]' if spaces and tabs are used to indent
" return an empty string if everything is fine
"
" Indentation functions borrowed from airline, they do this pretty well.
" Mixed indentation within a line. Returns the line number, or 0.
function! s:check_mixed_line_indent()
    " [<tab>]<space><tab>
    " spaces before or between tabs are not allowed
    let t_s_t = '(^\t* +\t\s*\S)'
    " <tab>(<space> x count)
    " count of spaces at the end of tabs should be less than tabstop value
    let t_l_s = '(^\t+ {' . &ts . ',}' . '\S)'
    return search('\v' . t_s_t . '|' . t_l_s, 'nw')
endfunction

" Mixed indentation across the file. Returns line numbers
" with_tabs:with_spaces, or empty string
function! s:check_mixed_indent_file()
    let c_like_langs = ['arduino', 'c', 'cpp', 'cuda', 'go', 'javascript', 'ld', 'php' ]
    if index(c_like_langs, &ft) > -1
        " for C-like languages: allow /** */ comment style with one space before the '*'
        let head_spc = '\v(^ +\*@!)'
    else
        let head_spc = '\v(^ +)'
    endif
    let indent_tabs = search('\v(^\t+)', 'nw')
    let indent_spc  = search(head_spc, 'nw')
    if indent_tabs > 0 && indent_spc > 0
        return printf("%d:%d", indent_tabs, indent_spc)
    else
        return ''
    endif
endfunction

function! statusline#StatuslineTabWarning()
    if &readonly || &bt == "nofile"
        return ""
    endif

    if !exists("b:statusline_tab_warning")
        let mixed_on_line = s:check_mixed_line_indent()
        let mixed_on_line_str = mixed_on_line ==# 0 ? '' : '[mixed-line '..mixed_on_line..']'
        let mixed_in_file = s:check_mixed_indent_file()
        let mixed_in_file_str = empty(mixed_in_file) ? '' : '[mixed-indenting '..mixed_in_file..']'
        let b:statusline_tab_warning = mixed_on_line_str .. mixed_in_file_str
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
    " From vimtex documentation:
    let VIMTEX_SUCCESS = 2
    let VIMTEX_FAIL = 3

    if exists('b:vimtex') && b:vimtex->has_key('compiler')
      let l:str = ""
      if b:vimtex['compiler']['continuous']
        let l:str ..= "🔄 "
      endif

      if b:vimtex['compiler']['status'] ==# VIMTEX_SUCCESS
        return l:str..'✅ {'.(fnamemodify(b:vimtex['tex'], ":p:.")).'}'
      elseif b:vimtex['compiler']['status'] ==# VIMTEX_FAIL
        return l:str..'❌ {'.(fnamemodify(b:vimtex['tex'], ":p:.")).'}'
      elseif b:vimtex['compiler']['is_running']()
        return l:str..'🔨  {'.(fnamemodify(b:vimtex['tex'], ":p:.")).'}'
      endif
    endif
    return ''
endfunction

function! statusline#StatuslineRemoteFile()
    if exists('b:netrw_lastfile')
        return ' ('.b:netrw_lastfile.')'
    endif
    return ''
endfunction

