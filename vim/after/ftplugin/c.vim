if v:version >= 800
  packadd termdebug
endif
let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'nmapc <buffer>'
setlocal path+=/usr/include,/usr/local/include,/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include,/usr/lib,/usr/local/Cellar/gcc*/**/include/**
let &l:include='^\s*#\s*include\s*["<]\zs.*\ze[>"]'
setlocal includeexpr=
let &l:define='\v^\s*(#\s*define)|((const )?(int|char|void|s?size_t) \*? ?)|(struct \ze\k+ \{)|(struct \k+ \ze\k+;)'
let &l:iskeyword='a-z,A-Z,48-57,_,.'

set foldmethod=syntax
