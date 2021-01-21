if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  autocmd! BufRead,BufNewFile *.nfo,*.NFO setfiletype nfo
  autocmd! BufRead,BufNewFile *.puml setfiletype plantuml
  autocmd! BufRead,BufNewFile *.ms,*.mom,*.mm setfiletype groff
augroup END
