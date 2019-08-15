setlocal makeprg=gnatmake\ %
setlocal errorformat=%f:%l:%c:\ %m,%f:%l:%c:\ %tarning:\ %m,%f:%l:%c:\ (%ttyle)\ %m
let b:undo_ftplugin .= '|setlocal makeprg< errorformat<'
