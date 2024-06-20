if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  autocmd! BufRead,BufNewFile *.nfo,*.NFO setfiletype nfo
  autocmd! BufRead,BufNewFile *.puml setfiletype plantuml
  autocmd! BufRead,BufNewFile *.ms,*.mom,*.mm setfiletype groff
  autocmd! BufRead,BufNewFile docker-compose.yml setfiletype yaml.docker-compose
augroup END
