let s:seshdir = $HOME.'/.vim/sessions/'
function! sessions#SaveSession() abort
  silent call mkdir (s:seshdir, 'p')
  let name = input("Save as: ")
  if name == ""
    echo "\nNo name provided."
  else
    let seshfile = s:seshdir.name.".vim"
    execute "mksession! " . seshfile
    echo "\nSession saved: ".seshfile
  endif
endfunction
function! s:ListSessions() abort
  silent call mkdir (s:seshdir, 'p')
  let files = globpath(s:seshdir, '*', 0, 1)
  call filter(files, '!isdirectory(v:val)')
  return files
endfunction
function! s:ChooseSession() abort
  let files = <SID>ListSessions()
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
function! sessions#LoadSession() abort
  let session = <SID>ChooseSession()
  if session != ""
    execute 'source '.session
  else
    echo "\nNo session selected."
  endif
endfunction
function! sessions#DeleteSession() abort
  let sesh = <SID>ChooseSession()
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
function! sessions#CloseSession()
  bufdo! bwipeout
  cd
  if exists('g:loaded_tagbar') && g:loaded_tagbar == 1
    execute "TagbarClose"
  endif
  echom "Session closed."
endfunction
