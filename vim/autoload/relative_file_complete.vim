" Save cwd, cd to dir enclosing file, then go back to saved dir when complete done
function! relative_file_complete#SaveAndRestoreOnComplete()
  " Save the old cwd
  let s:olddir = getcwd()

  " Locally switch to the dir enclosing current file
  lcd %:p:h

  " Defer changing cwd back until complete is done
  augroup relative_file_complete_reset_cwd
    au!
    au CompleteDone <buffer> call relative_file_complete#Cleanup()
  augroup END
endfunction

" When complete finishes, need to change cwd back and clear autocmd
function! relative_file_complete#Cleanup()
  " Go back to the previous dir and remove the saved variable
  exe "lcd ".s:olddir
  unlet s:olddir

  " Clear the cleanup autocmd and augroup
  augroup relative_file_complete_reset_cwd
    au!
  augroup END
  augroup! relative_file_complete_reset_cwd
endfunction
