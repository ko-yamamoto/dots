# virtualbox のコピペ共有などを有効にする（sudo設定が必要）
# sudo VBoxClient-all &

# インプットメソッドの起動
export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
uim-xim &
export XMODIFIERS=@im='uim'
uim-toolbar-gtk &

xrdb -merge $HOME/.Xresources

# 解像度調整
xrandr -s 1280x720

# タッチパッド関連 ##########
syndaemon -t -k -d &

# keymap
xmodmap $HOME/.xmodmaprc

hsetroot
xsetroot -cursor_name left_ptr

# 日本語キーボードの設定
setxkbmap -layout jp

exec xmonad

