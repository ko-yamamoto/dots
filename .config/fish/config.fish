# PATH
set GOPATH $HOME/go
set PATH $PATH $HOME/.autojump/bin $GOPATH/bin $HOME/.cabal/bin $HOME/bin $HOME/.rbenv/bin /usr/bin /opt/bin


# alias や function で作った別名コマンドに補完を適用する関数
function make_completion --argument-names alias command
    echo "
    function __alias_completion_$alias
        set -l cmd (commandline -o)
        set -e cmd[1]
        complete -C\"$command \$cmd\"
    end
    " | .
    complete -c $alias -a "(__alias_completion_$alias)"
end

# ログインメッセージ無効
set fish_greeting ""


# cd したあとに ls
function cd
    builtin cd $argv
    echo $PWD >> $CD_HISTORY_FILE # percol_cd_history 用
    ls
end

# emacsclient を ec で
function ec
    emacsclient -n $argv
end

# git を g で
function g
    git $argv
end
# g で実行する git に補完実行
make_completion g 'git'




##
# Read Z extension
##
if test -f $HOME/bin/z-fish/z.fish
  . $HOME/bin/z-fish/z.fish
end

#
# for autojump
#
function j
   cd (command autojump $argv)
end

# percol を使った history 補完
function percol_select_history
  history|percol|read percolhistry
  if [ $percolhistry ]
    commandline $percolhistry
  else
    commandline ''
  end
end


set CD_HISTORY_FILE $HOME/.cd_history_file # cd 履歴の記録先ファイル
# percol を使って cd 履歴の中からディレクトリを選択
# 過去の訪問回数が多いほど選択候補の上に来る
function percol_cd_history
  sort $CD_HISTORY_FILE | uniq -c | sort -r | sed -e 's/^[ ]*[0-9]*[ ]*//' | percol | read -l percolCDhistory
  if [ $percolCDhistory ]
    commandline 'cd '
    commandline -i $percolCDhistory
  else
    commandline ''
  end
end


# キーバインドの追加 ############################################
function fish_user_key_bindings
  bind \cr percol_select_history
  bind \cx percol_cd_history
end


# 環境毎の設定読み込み ##########################################
switch (uname)
  case Darwin
    . $HOME/.config/fish/config_mac.fish
  case Linux
    . $HOME/.config/fish/config_gentoo.fish
end
