# Mac 用設定

# emacsclient を ec で
function emacsclient
    /Applications/Emacs.app/Contents/MacOS/bin/emacsclient $argv
end


# emacsclient を ec で
function ec
    emacsclient -n $argv
end

# ssh-agent
set agentPID (ps gxww | grep "ssh-agent]*\$" | awk '{print $1}') | head -1
set agentSOCK (/bin/ls -t /private/var/folders/fw/_tk7tz0x0g95c6jp7gw2j4hr0000gn/T/ssh*/agent*|head -1)
if test "$agentPID" = "" -o "$agentSOCK" = ""
    set -e SSH_AUTH_SOCK
    set -e SSH_AGENT_PID
    eval (ssh-agent)
    ssh-add
else
    set --export SSH_AGENT_PID $agentPID
    set --export SSH_AUTH_SOCK $agentSOCK
    # if [ `ssh-add -l` = "" ]; then
    #     ssh-add < /dev/null
    # fi
end
