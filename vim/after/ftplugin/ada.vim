" These two mappings come from the default ada ftplugin
iunmap <buffer> <leader>aj
iunmap <buffer> <leader>al

let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
setlocal suffixesadd+=.adb,.ads
let &l:include='^\s*with'
let &l:define='^\s*\(function\|type\|subtype\|procedure\)'
let b:undo_ftplugin .= 'setlocal makeprg< errorformat< suffixesadd< include< define<'
