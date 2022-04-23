if exists("g:loaded_fzf_changes_jumps") || &cp
  finish
endif

let g:loaded_fzf_changes_jumps = 1
command! Changes call fzf_changes_jumps#Changes()
command! Jumps call fzf_changes_jumps#Jumps()
nnoremap <Plug>FzfChangesJumpsChanges :Changes<CR>
nnoremap <Plug>FzfChangesJumpsJumps :Jumps<CR>
