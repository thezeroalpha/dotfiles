let g:NERDSpaceDelims = 1
let g:vimwiki_list = [{'path': '$HOME/Dropbox/vimwiki', 
	    \ 'template_path': '$HOME/Dropbox/vimwiki/templates',
	    \ 'template_default': 'default',
	    \ 'template_ext': '.html'}]

let tlist_vimwiki_settings = 'wiki;h:Headers'

" tagbar language definitions
let g:tagbar_type_vimwiki = {
          \   'ctagstype':'vimwiki'
          \ , 'kinds':['h:header']
          \ , 'sro':'&&&'
          \ , 'kind2scope':{'h':'header'}
          \ , 'sort':0
          \ , 'ctagsbin':'$CONF_DIR/scripts/vwtags.py'
          \ , 'ctagsargs': 'default'
          \ }

let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ],
    \ 'sort': 0
\ }

" vim-qf mappings
nmap ]q <Plug>(qf_qf_next)
nmap [q <Plug>(qf_qf_previous)
nmap <leader>qf <Plug>(qf_qf_toggle)
