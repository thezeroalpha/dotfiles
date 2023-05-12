if g:loaded_plug
  if has('nvim')
    command! PU PlugUpgrade | PlugUpdate
    command! PI PlugInstall
    command! PC PlugClean
  else
    command! PU PlugUpgrade | PlugUpdate
    command! PI PlugInstall
    command! PC PlugClean
  endif
endif
