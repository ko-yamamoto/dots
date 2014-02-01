set --export JAVA_HOME $HOME/.gentoo/java-config-2/current-user-vm

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
    # if [ `ssh-add -l` = "" ]; then
    #     ssh-add < /dev/null
    # fi
end
