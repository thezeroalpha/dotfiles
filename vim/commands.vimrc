" Custom commands
command! Todo vimgrep /TODO\C<Bslash><Bar>TO DO\C/ **/*.* | copen
command! Note vimgrep /NOTE\C/ **/*.* | copen
command! Fix vimgrep /FIXME\C/ **/*.* | copen
command! ListFileTypes echo glob($VIMRUNTIME . '/syntax/*.vim')
command! CDC cd %:p:h
command! Maketab set noet ts=2 | %retab!
command! Diff w !diff % -
command! Diffc w !git diff % -
command! Fuckwindows %s///g
command! Hexedit %!xxd
command! Unhex %!xxd -r
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-n>"
    endif
endfunction

" Fat finger fixes/convenience abbreviations
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
