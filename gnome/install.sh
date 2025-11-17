#!/bin/sh
PREFIX="/usr"
PATH_DWM_GNOME="$PREFIX/bin/dwm-gnome"
PATH_DWM_GNOME_DESKTOP="$PREFIX/share/applications/dwm-gnome.desktop"
PATH_DWM_GNOME_SESSION="$PREFIX/share/gnome-session/sessions/dwm-gnome.session"
PATH_DWM_GNOME_XSESSION="$PREFIX/share/xsessions/dwm-gnome.desktop"
PATH_GNOME_SESSION_DWM="$PREFIX/bin/gnome-session-dwm"
sudo install -m0644 -D session/dwm-gnome-xsession.desktop $PATH_DWM_GNOME_XSESSION
sudo install -m0644 -D session/dwm-gnome.desktop $PATH_DWM_GNOME_DESKTOP
sudo install -m0644 -D session/dwm-gnome.session $PATH_DWM_GNOME_SESSION
sudo install -m0755 -D session/dwm-gnome $PATH_DWM_GNOME
sudo install -m0755 -D session/gnome-session-dwm $PATH_GNOME_SESSION_DWM


