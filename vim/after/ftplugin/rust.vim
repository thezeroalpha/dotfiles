setlocal formatprg=rustfmt
setlocal makeprg=cargo\ build
setlocal keywordprg=rustup\ doc
let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin.'|' : '')
let b:undo_ftplugin .= 'setlocal formatprg< makeprg< keywordprg<'
