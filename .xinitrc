#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#
xrdb -merge $HOME/.Xresources

VBoxClient-all &

nm-applet &

/usr/bin/autokey-gtk &

input method
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
fcitx
# export GTK_IM_MODULE='uim'
# export QT_IM_MODULE='uim'
# export XMODIFIERS=@im='uim'
# uim-xim &
# uim-toolbar-gtk &


eval $(ssh-agent)

xhost local:0.0
systemctl --user restart rbindkeys.service

compton &

exec $1
