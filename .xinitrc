# virtualbox のコピペ共有などを有効にする（sudo設定が必要）
sudo VBoxClient-all &

# インプットメソッドの起動
export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
uim-xim &
export XMODIFIERS=@im='uim'
uim-toolbar-gtk &

xrdb -merge $HOME/.Xresources

# 解像度調整
# xrandr -s 1280x720

# タッチパッド関連 ##########
# 感度
# synclient FingerHigh=70
# 2本タップを右、3本タップを中クリックに
# synclient TapButton1=1
# synclient TapButton2=2
# synclient TapButton3=3
# 手の平での誤爆防止
# synclient PalmDetect=1
# syndaemon -t -k -d &


# キー変更 #################
# xmodmap ~/.xmodmaprc



# hsetroot
xsetroot -cursor_name left_ptr

# 日本語キーボードの設定
# setxkbmap -layout jp
setxkbmap -model us -layout us

google-ime-skk &

exec xmonad

