set --export LANG "ja_JP.UTF-8"

# PATH
set --export GOPATH $HOME/go
set PATH $HOME/.autojump/bin $GOPATH/bin $HOME/.cabal/bin $HOME/.rbenv/shims $HOME/bin $HOME/.rbenv/bin /usr/bin /opt/bin $PATH


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
# function cd
#     builtin cd $argv
#     echo $PWD >> $CD_HISTORY_FILE # percol_cd_history 用
#     ls
# end
function cd --description "Change directory"

        # Skip history in subshells
        if status --is-command-substitution
                builtin cd $argv
                  echo $PWD >> $CD_HISTORY_FILE # percol_cd_history 用
                  ls
                return $status
        end

        # Avoid set completions
        set -l previous $PWD

        if test $argv[1] = - ^/dev/null
                if test "$__fish_cd_direction" = next ^/dev/null
                        nextd
                else
                        prevd
                end

                echo $PWD >> $CD_HISTORY_FILE # percol_cd_history 用
                ls
                return $status
        end

        builtin cd $argv[1]
        set -l cd_status $status

        if test $cd_status = 0 -a "$PWD" != "$previous"
                set -g dirprev $dirprev $previous
                set -e dirnext
                set -g __fish_cd_direction prev
        end

        echo $PWD >> $CD_HISTORY_FILE # percol_cd_history 用
        ls

        return $cd_status
end


# プロンプトの pwd 表示を変更
if test (uname) = Darwin
        function prompt_pwd --description "Print the current working directory, shortend to fit the prompt"
                echo $PWD | sed -e "s|^$HOME|~|" -e 's|^/private||' -e 's-\([^/]\{,5\}\)[^/]*/-\1\.\./-g'
        end
else
        function prompt_pwd --description "Print the current working directory, shortend to fit the prompt"
                echo $PWD | sed -e "s|^$HOME|~|" -e 's-\([^/]\{,5\}\)[^/]*/-\1\.\./-g'
        end
end


# top の代わりに htop する
function top
    htop $args
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
    # commandline 'cd '
    # commandline -i $percolCDhistory
    echo 'cd' $percolCDhistory
    cd $percolCDhistory
    echo $percolCDhistory
    commandline -f repaint
  else
    commandline ''
  end
end


# キーバインドの追加 ############################################
function fish_user_key_bindings
  bind \cg 'commandline ""' # C-g で C-c する
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






set fish_color_search_match --background=white
set fish_color_command blue
set fish_color_error red
set fish_color_autosuggestion yellow
set fish_color_param green

# other-writable(777) なものは赤い下線
set --export LS_COLORS "ow=04;31:tw=04;31"