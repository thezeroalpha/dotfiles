if g:loaded_plug
  if has('nvim')
    command! PU PlugUpgrade | PlugUpdate | PackerSync
    command! PI PlugInstall | PackerInstall | PackerSync
    command! PC PlugClean | PackerClean
  else
    command! PU PlugUpgrade | PlugUpdate
    command! PI PlugInstall
    command! PC PlugClean
  endif
endif
