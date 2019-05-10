" Functions
function! InsertTabWrapper() abort
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-n>"
    endif
endfunction

function! ToggleNumber() abort
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

function! Redir(cmd) abort
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

function! DeleteHiddenBuffers() " Vim with the 'hidden' option
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
	silent execute 'bwipeout' buf
    endfor
endfunction

let g:NetrwIsOpen=0
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout! " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction
" Custom session management (should be plugin) {{{
function! SaveSession() abort
    let seshdir = $HOME.'/.vim/sessions/'
    silent call mkdir (seshdir, 'p')
    let name = input("Save as: ")
    if name == ""
    	echo "\nNo name provided."
    else
	let seshfile = seshdir.name.".vim"
	execute "mksession! " . seshfile
	echo "\nSession saved: ".seshfile
    endif
endfunction
function! ListSessions() abort
    let seshdir = $HOME.'/.vim/sessions/'
    silent call mkdir (seshdir, 'p')
    let files = globpath(seshdir, '*', 0, 1)
    call filter(files, '!isdirectory(v:val)')
    return files
endfunction
function! ChooseSession() abort
    let files = ListSessions()
    if len(files) > 0
	let inputfiles = map(copy(files), 'index(files, v:val)+1.": ".v:val')
	let response = inputlist(inputfiles)
	if response > 0
	    return files[response-1]
	else
	    return ""
	endif
    else
    	echo "No sessions available."
    	return ""
    endif
endfunction
function! LoadSession() abort
    let session = ChooseSession()
    if session != ""
	execute 'source '.session
    else
    	echo "\nNo session selected."
    endif
endfunction
function! DeleteSession() abort
    let sesh = ChooseSession()
    if sesh == ""
    	echo "\nNo session selected"
    	return 1
    endif
    let conf = confirm("Delete ".sesh."?", "&Yes\n&No\n", 2)
    if conf == 1
	if delete(sesh) == 0
	    echom "Deleted ".sesh
	else
	    echom "Couldn't delete ".sesh
	endif
    else
    	echom "No action taken."
    endif
endfunction
function! CloseSession()
    bufdo! bwipeout
    cd
    if g:loaded_tagbar == 1
    	execute "TagbarClose"
    endif
    echom "Session closed."
endfunction
" }}}

" Custom commands
command! Light set background=light | e
command! Dark set background=dark | e
command! TodoP vimgrep /^ *[#%\/E]* *\(TODO\|TO DO\)/ **/*.* | copen
command! Todo vimgrep /^ *[#%\/E]* *\(TODO\|TO DO\)/ % | copen
command! NoteP vimgrep /NOTE\C/ **/*.* | copen
command! Note vimgrep /NOTE\C/ % | copen
command! FixP vimgrep /FIXME\C/ **/*.* | copen
command! Fix vimgrep /FIXME\C/ % | copen
command! ListFileTypes echo glob($VIMRUNTIME . '/syntax/*.vim')
command! CDC cd %:p:h
command! LCDC lcd %:p:h
command! Maketab set noet ts=2 | %retab!
command! Diff w !diff % -
command! Diffc w !git diff % -
command! Fuckwindows %s///g
command! Hexedit %!xxd
command! Unhex %!xxd -r
command! JsonSimplifyObject %s/^\(\s\{10}\){\n\s\{12\}\(.*\)\n\s\{10\}}\(,\?\)/\1{ \2 }\3
command! BeautifyJson %!python -m json.tool
command! Dos2unix .!dos2unix "%"
command! DeleteHiddenBuffers call DeleteHiddenBuffers()
command! -nargs=1 -complete=command Redir silent call Redir(<f-args>)
" Usage:
" 	:Redir hi ............. show the full output of command ':hi' in a scratch window
" 	:Redir !ls -al ........ show the full output of command ':!ls -al' in a scratch window


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
if has('terminal')
    cnoreabbrev tt tab terminal
    cnoreabbrev wt terminal
endif
