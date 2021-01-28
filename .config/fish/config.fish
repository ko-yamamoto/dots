# set -x LANG "ja_JP.UTF-8"
set -x LANG "en_US.utf8"

set PATH $HOME/bin $HOME/.cargo/bin /home/linuxbrew/.linuxbrew/bin $PATH

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
setenv SSH_ENV $HOME/.ssh/environment
function start_agent
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    echo "succeeded"
    chmod 600 $SSH_ENV
    . $SSH_ENV > /dev/null
    ssh-add
end
function test_identities
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end
if [ -n "$SSH_AGENT_PID" ]
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    end
else
    if [ -f $SSH_ENV ]
        . $SSH_ENV > /dev/null
    end
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    else
        start_agent
    end
end


# overwrite functions
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
    emacs26 &
    disown (ps --no-headers -C emacs26 -o pid)
end
function ec
    emacsclient26 -n $argv
end


# other-writable(777) なものは赤い下線
set --export LS_COLORS "ow=04;31:tw=04;31"
