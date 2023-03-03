" Search folding (after any regular search, this folds all non-matched lines)
function! searchfold#Toggle() abort
  if exists('b:search_folded') && b:search_folded
    setlocal foldexpr< foldmethod< foldenable< foldlevel<
    let b:search_folded = 0
  else
    setlocal foldexpr=getline(v:lnum)!~@/
    setlocal foldmethod=expr
    setlocal foldenable
    setlocal foldlevel=0
    let b:search_folded = 1
  endif
endfunction
