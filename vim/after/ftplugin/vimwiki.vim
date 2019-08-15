setlocal wrap shiftwidth=4 tabstop=4 softtabstop=4 breakindent breakindentopt=shift:3
cabbrev <buffer> table VimwikiTable
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '|setlocal wrap< shiftwidth< tabstop< softtabstop< breakindent< breakindentopt<'
else
  let b:undo_ftplugin = 'setlocal wrap< shiftwidth< tabstop< softtabstop< breakindent< breakindentopt<'
endif
