#!/bin/sh
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -z "$DOTFILES" ]; then
  export DOTFILES="$HOME/.dotfiles"
  . "$DOTFILES"/shell/env
  . "$DOTFILES"/shell/paths
fi
setxkbmap -option ctrl:nocaps &
xcape &
{ wal -R && xdotool key "super+shift+r"; } &
export SHLVL=1
export _JAVA_AWT_WM_NONREPARENTING=1 # otherwise Ghidra shows a blank screen
eval $(ssh-agent -s) &
command -v VBoxClient-all >/dev/null 2>&1 && VBoxClient-all &
xset r rate 300 50 &
dwmblocks 2>/var/log/dwm/dwmblocks.log &
dunst 2>/var/log/dunst/dunst.log &
unclutter &
xcompmgr -f -c -C -D 2 &
sxhkd 2>/var/log/sxhkd/sxhkd.log &
exec $HOME/.scripts/startdwm
