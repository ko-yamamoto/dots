# virtualbox のコピペ共有などを有効にする（sudo設定が必要）
sudo VBoxClient-all &

# 日本語キーボードの設定
# setxkbmap -layout jp

# インプットメソッドの起動
export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
uim-xim &
export XMODIFIERS=@im='uim'
uim-toolbar-gtk &

xrdb -merge $HOME/.Xresources

hsetroot
xsetroot -cursor_name left_ptr
setxkbmap -layout jp
exec xmonad

