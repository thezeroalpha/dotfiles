autocmd User Fugitive command! -buffer -bar Glg exe 'terminal ++close' FugitivePrepare(['log', '--oneline', '--decorate', '--graph', '--all'])
