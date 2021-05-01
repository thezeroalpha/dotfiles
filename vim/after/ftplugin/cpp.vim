" According to Google Style Guide
" https://google.github.io/styleguide/cppguide.html
setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=8

let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'setlocal expandtab< shiftwidth< softtabstop< tabstop<'

