# set -x LANG "ja_JP.UTF-8"
set -x LANG "en_US.utf8"

set PATH $HOME/bin $PATH

set -x DISPLAY localhost:0.0

function peco_select_history
    if set -q $argv
        history | peco | read -l line && commandline $line
    else
        history | peco --query $argv | read -l line && commandline $line
    end

    commandline -f repaint
end

#peco
function fish_user_key_bindings
    bind \cr peco_select_history
    end


# ssh-agent
set agentPID (ps gxww | grep "ssh-agent]*\$" | awk '{print $1}') | head -1
set agentSOCK (/bin/ls -t /tmp/ssh*/agent*|head -1)
if test "$agentPID" = "" -o "$agentSOCK" = ""
    set -e SSH_AUTH_SOCK
    set -e SSH_AGENT_PID
    eval (ssh-agent)
    ssh-add
else
    set --export SSH_AGENT_PID $agentPID
    set --export SSH_AUTH_SOCK $agentSOCK
    # if [ `ssh-add -l` = "" ]; then    #     ssh-add < /dev/null
    # fi
end


function cd
    if test (count $argv) -eq 0
        cd $HOME
        return 0
    else if test (count $argv) -gt 1
        printf "%s\n" (_ "Too many args for cd command")
        return 1
    end
    # Avoid set completions.
    set -l previous $PWD

    if test "$argv" = "-"
        if test "$__fish_cd_direction" = "next"
            nextd
        else
            prevd
        end
        return $status
    end
    builtin cd $argv
    set -l cd_status $status
    # Log history
    if test $cd_status -eq 0 -a "$PWD" != "$previous"
        set -q dirprev[$MAX_DIR_HIST]
        and set -e dirprev[1]
        set -g dirprev $dirprev $previous
        set -e dirnext
        set -g __fish_cd_direction prev
    end

    if test $cd_status -ne 0
        return 1
    end
    ls
    return $status
end


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


# git を g で
function g
    git $argv
end
# g で実行する git に補完実行
make_completion g 'git'


function runemacs
    nohup emacs26 &
end
function ec
    emacsclient26 -n $argv
end


# other-writable(777) なものは赤い下線
set --export LS_COLORS "ow=04;31:tw=04;31"
