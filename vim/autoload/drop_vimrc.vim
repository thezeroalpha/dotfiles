" Drop to vimrc without changing args
"  (because :drop clobbers args)
function! drop_vimrc#DropToFoldedVimrc()
  let s:args = expand("##")
  drop $MYVIMRC
  setlocal foldmethod=marker foldlevel=0
  argdelete *

  exe "argadd ".s:args
  unlet s:args
endfunction
