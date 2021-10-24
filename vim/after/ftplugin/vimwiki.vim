setlocal wrap shiftwidth=4 tabstop=4 softtabstop=4 breakindent breakindentopt=shift:3

nmap <buffer> <leader><CR> <Plug>VimwikiSplitLink

let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'setlocal wrap< shiftwidth< tabstop< softtabstop< breakindent< breakindentopt<'
let b:undo_ftplugin .= '| cabc <buffer>'
let b:undo_ftplugin .= '| nmapc <buffer>'
