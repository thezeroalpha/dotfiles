if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  autocmd! BufRead,BufNewFile *.nfo,*.NFO setfiletype nfo
  autocmd! BufRead,BufNewFile *.puml setfiletype plantuml
augroup END
