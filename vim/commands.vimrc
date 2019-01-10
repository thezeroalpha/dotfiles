" Custom commands
command! TodoP vimgrep /TODO\C<Bslash><Bar>TO DO\C/ **/*.* | copen
command! Todo vimgrep /TODO\C<Bslash><Bar>TO DO\c/ % | copen
command! NoteP vimgrep /NOTE\C/ **/*.* | copen
command! Note vimgrep /NOTE\C/ % | copen
command! FixP vimgrep /FIXME\C/ **/*.* | copen
command! Fix vimgrep /FIXME\C/ % | copen
command! ListFileTypes echo glob($VIMRUNTIME . '/syntax/*.vim')
command! CDC cd %:p:h
command! Maketab set noet ts=2 | %retab!
command! Diff w !diff % -
command! Diffc w !git diff % -
command! Fuckwindows %s///g
command! Hexedit %!xxd
command! Unhex %!xxd -r
command! JsonSimplifyObject %s/^\(\s\{16}\){\n\s\{20\}\(.*\)\n\s\{16\}}\(,\?\)/\1{\2}\3
command! BeautifyJson %!python -m json.tool
command! -nargs=1 -complete=command Redir silent call Redir(<f-args>)
" Usage:
" 	:Redir hi ............. show the full output of command ':hi' in a scratch window
" 	:Redir !ls -al ........ show the full output of command ':!ls -al' in a scratch window

" Functions
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-n>"
    endif
endfunction

function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

function! Redir(cmd)
	for win in range(1, winnr('$'))
		if getwinvar(win, 'scratch')
			execute win . 'windo close'
		endif
	endfor
	if a:cmd =~ '^!'
		execute "let output = system('" . substitute(a:cmd, '^!', '', '') . "')"
	else
		redir => output
		execute a:cmd
		redir END
	endif
	vnew
	let w:scratch = 1
	setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
	call setline(1, split(output, "\n"))
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
cnoreabbrev lset setl
